import 'package:flutter/material.dart';
import 'package:flutterapp/enums/race_status.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/widget/nav_drawer_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_ranking_item_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_ranking_type_bar_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_stats_bar_widget.dart';

class RecordActivityWidget extends StatefulWidget {
  final AbstractActivityLocationObserver observer;
  final Color materialPalette;

  RecordActivityWidget(this.observer, this.materialPalette);

  _RecordActivityWidgetState createState() => _RecordActivityWidgetState();
}

abstract class RecordActivityWidgetState extends State<RecordActivityWidget> {
  void updateState(RecordActivityWidgetModel model);
  void finish(RecordActivityWidgetModel model);
}

class _RecordActivityWidgetState extends RecordActivityWidgetState {
  RecordActivityWidgetModel _model = new RecordActivityWidgetModel(0.0, 0.0, 0, RaceStatus.NOT_STARTED, new List<RecordActivityWidgetRankingItem>());
  callback(newRankingType) {
    setState(() {
      print("new type $newRankingType");
      widget.observer.updateRankingType(newRankingType);
    });
  }

  void initState() {
    super.initState();
    widget.observer.init(this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(widget.materialPalette),
      appBar: AppBar(
        title: Text('Record activity'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RecordActivityStatsBarWidget(_model, widget.materialPalette),
            RecordActivityRankingTypeBarWidget(callback, widget.materialPalette),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: _model.ranking.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecordActivityRankingItemWidget(_model.ranking[index], widget.materialPalette, index + 1);
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

  void finish(RecordActivityWidgetModel model) {
    print("Finish");
  }
}
