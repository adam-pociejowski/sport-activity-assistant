import 'package:flutter/material.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/widget/nav_drawer_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_ranking_item_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_stats_bar_widget.dart';

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
  RecordActivityWidgetModel _model = new RecordActivityWidgetModel(0.0, 0.0, 0, new List<RecordActivityWidgetRankingItem>());

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
            RecordActivityStatsBarWidget(_model, materialPalette),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: _model.ranking.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecordActivityRankingItemWidget(_model.ranking[index], materialPalette, index + 1);
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
}
