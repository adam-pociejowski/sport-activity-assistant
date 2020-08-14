import 'package:flutter/material.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/widget/nav_drawer_widget.dart';
import 'package:intl/intl.dart';

class RecordActivityWidget extends StatefulWidget {
  final AbstractActivityLocationObserver observer;

  RecordActivityWidget(this.observer);

  @override
  _RecordActivityWidgetState createState() => _RecordActivityWidgetState();
}

abstract class RecordActivityWidgetState extends State<RecordActivityWidget> {
  void updateState(RecordActivityWidgetModel model);
}

class _RecordActivityWidgetState extends RecordActivityWidgetState {
  static var materialPalette = Colors.lime;
  RecordActivityWidgetModel _model = new RecordActivityWidgetModel(0.0, 0, new List<RecordActivityWidgetRankingItem>());
  var shade100Color = materialPalette.shade100;
  var shade200Color = materialPalette.shade200;
  var shade300Color = materialPalette.shade300;
  var shade400Color = materialPalette.shade400;

  void initState() {
    super.initState();
    widget.observer.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(),
      appBar: AppBar(
        title: Text('Record activity'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              color: shade300Color,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(new NumberFormat("##0.00", "en_US").format(_model.currentDistanceInKm).toString() + ' km', style: TextStyle(fontSize: 50)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('${_model.currentPlayerPosition}/${_model.ranking.length}', style: TextStyle(fontSize: 50)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: _model.ranking.length,
                itemBuilder: (BuildContext context, int index) {
                  final RecordActivityWidgetRankingItem item = _model.ranking[index];
                  return Card(
                    color: _decideWhichItemColor(item.itemType),
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          _prepareColumn('${(index + 1)}.', 10, CrossAxisAlignment.start),
                          _prepareFlagImage(item.country, 8, CrossAxisAlignment.start),
                          _prepareColumn(item.name, 46, CrossAxisAlignment.start),
                          _prepareColumn(item.power.toString(), 12, CrossAxisAlignment.start),
                          _prepareColumn(item.timeText, 24, CrossAxisAlignment.end)
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateState(RecordActivityWidgetModel model) {
    setState(() {
      _model = model;
    });
  }

  Color _decideWhichItemColor(RankingItemRaceEventType type) {
    switch (type) {
      case RankingItemRaceEventType.USER_ACTIVITY:
        return shade300Color;
      case RankingItemRaceEventType.USER_OLD_ACTIVITY:
        return shade200Color;
      default:
        return shade100Color;
    }
  }

  Expanded _prepareFlagImage(String country, int flex, CrossAxisAlignment align) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 2.0, right: 6.0),
            child: Image(
              image: AssetImage("assets/images/flags_light/$country.png"),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _prepareColumn(String text, int flex, CrossAxisAlignment align) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Text(text, style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
