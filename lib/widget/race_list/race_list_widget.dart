import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/enums/race_status.dart';
import 'package:flutterapp/model/simulate/race_config.dart';
import 'package:flutterapp/service/simulate_race_location_observer.dart';
import 'package:flutterapp/util/datetime_utils.dart';
import 'package:flutterapp/util/htttp_utils.dart';
import 'package:flutterapp/widget/nav_drawer_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_widget.dart';
import 'package:global_configuration/global_configuration.dart';

class RaceListWidget extends StatefulWidget {
  MaterialColor materialColor;

  RaceListWidget(this.materialColor);

  _RaceListWidgetState createState() => _RaceListWidgetState();
}

class _RaceListWidgetState extends State<RaceListWidget> {
  final apiUrl = GlobalConfiguration().getString("sport_activity_api_url");
  List<RaceConfig> races;

  void initState() {
    super.initState();
    _findRaceConfigs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(),
      appBar: AppBar(
        title: Text('Choose activity type'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: races == null ? 0 : races.length,
                itemBuilder: (BuildContext context, int index) {
                  return _prepareActivityTypeRow(
                      index + 1,
                      widget.materialColor,
                      races[index],
                      () => RecordActivityWidget(new SimulateRaceLocationObserver(races[index])));
                },
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new RecordActivityWidget(new SimulateRaceLocationObserver(null))),
                      );
                    },
                    child: const Text('Start new race', style: TextStyle(fontSize: 25)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<RaceConfig>> _findRaceConfigs() async {
    final Iterable iterable = json.decode(await HttpUtils.get('$apiUrl/race/list'));
    final List<RaceConfig> races = iterable
        .map((model) => RaceConfig.fromJson(model))
        .toList();
    races.sort((RaceConfig c1, RaceConfig c2) => c2.generateDate.compareTo(c1.generateDate));
    setState(() {
      this.races = races;
    });
  }

  Container _prepareActivityTypeRow(int position, MaterialColor palette, RaceConfig race, Function function) {
    return new Container(
      padding: const EdgeInsets.all(5.0),
      color: _chooseColorByStatus(race, palette),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[ Text(position.toString() + '.', style: TextStyle(fontSize: 25)) ],
            ),
          ),
          Expanded(
            flex: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[ Text(DateTimeUtils.toDateFormat(race.generateDate), style: TextStyle(fontSize: 25)) ],
            ),
          ),
          Expanded(
            flex: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => function()),
                    );
                  },
                  child: const Text('GO', style: TextStyle(fontSize: 25)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _chooseColorByStatus(RaceConfig race, MaterialColor palette) {
    switch (RaceStatus.findByName(race.status)) {
      case RaceStatus.NOT_STARTED:
        return palette.shade100;
      case RaceStatus.IN_PROGRESS:
        return palette.shade200;
      case RaceStatus.FINISHED:
        return palette.shade300;
      default:
        return palette.shade50;
    }
  }
}
