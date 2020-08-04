import 'package:flutter/material.dart';
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
  var lightColor = materialPalette.shade100;
  var mediumColor = materialPalette.shade300;
  var darkColor = materialPalette.shade400;

  @override
  Widget build(BuildContext context) {
    widget.observer.registerState(this);
    widget.observer.init();
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
              color: mediumColor,
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
                    color: item.isPlayerResult ? mediumColor : lightColor,
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          _prepareColumn('${(index + 1)}.', 10, CrossAxisAlignment.start),
                          _prepareColumn(item.name, 52, CrossAxisAlignment.start),
                          _prepareColumn(item.timeText, 38, CrossAxisAlignment.end)
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

  Expanded _prepareColumn(String text, int flex, CrossAxisAlignment align) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Text(text, style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
