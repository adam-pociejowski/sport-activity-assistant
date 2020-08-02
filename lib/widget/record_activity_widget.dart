import 'package:flutter/material.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/ranking/activity_ranking_item_info.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/model/ranking/activity_ranking.dart';
import 'package:flutterapp/model/ranking/activity_ranking_item.dart';
import 'package:flutterapp/widget/nav_drawer_widget.dart';
import 'package:flutterapp/util/datetime_utils.dart';
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
  RecordActivityWidgetModel _model;
  var lightColor = materialPalette.shade100;
  var mediumColor = materialPalette.shade300;
  var darkColor = materialPalette.shade400;

  _RecordActivityWidgetState() {
    widget.observer.registerState(this);
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
              padding: const EdgeInsets.all(12.0),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          _prepareColumn('${(index + 1)}.', 14, CrossAxisAlignment.start),
                          _prepareColumn(DateTimeUtils.toDateFormat(item.name), 46, CrossAxisAlignment.start),
                          _prepareColumn(item.timeText, 40, CrossAxisAlignment.end)
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
          Text(text, style: TextStyle(fontSize: 28)),
        ],
      ),
    );
  }

  ActivityRanking _addCurrentResult(ActivityRanking ranking) {
    final ActivityRankingItem currentResult = new ActivityRankingItem.current(
        new ActivityRankingItemInfo('Ride', DateTimeUtils.toDateFormatFromDate(new DateTime.now())),
        'Ride',
        playerActivityService.getActivityMovingTime(),
        true);
    final int currentResultIndex = _getCurrentResultIndex(ranking, currentResult);
    playerActivityService.currentPosition = currentResultIndex + 1;
    ranking.ranking.insert(currentResultIndex, currentResult);
    return ranking;
  }

  int _getCurrentResultIndex(ActivityRanking ranking, ActivityRankingItem currentResult) {
    for (ActivityRankingItem item in ranking.ranking) {
      if (item.timeInSec > currentResult.timeInSec) {
        return ranking.ranking.indexOf(item);
      }
    }
    return ranking.ranking.length;
  }

  ActivityRanking _addListViewFields(ActivityRanking ranking) {
    if (ranking.ranking.length > 0) {
      var bestResult;
      ranking.ranking.forEach((element) {
        if (ranking.ranking.indexOf(element) == 0) {
          bestResult = element;
          element.timeText = DateTimeUtils.formatTime(bestResult.timeInSec.round());
        } else {
          element.timeText = '+ ' + DateTimeUtils.formatTime(element.timeInSec.round() - bestResult.timeInSec.round());
        }
      });
    }
    return ranking;
  }
}
