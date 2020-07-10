import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/location/location_observer.dart';
import 'package:flutterapp/location/location_point.dart';
import 'package:flutterapp/location/location_service.dart';
import 'package:flutterapp/activity/activity_ranking.dart';
import 'package:flutterapp/activity/activity_ranking_item.dart';
import 'package:flutterapp/activity/activity_service.dart';
import 'package:flutterapp/util/datetime_utils.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RecordActivityWidget extends StatefulWidget {
  @override
  _RecordActivityWidgetState createState() => _RecordActivityWidgetState();
}

class _RecordActivityWidgetState extends State<RecordActivityWidget> implements LocationObserver {
  var locationService = new LocationService();
  var activityService = new ActivityService();
  var apiUrl = GlobalConfiguration().getString("sport_activity_api_url");
  var activityType = 'outdoor_ride';
  static var materialPalette = Colors.lime;
  var lightColor = materialPalette.shade100;
  var mediumColor = materialPalette.shade300;
  var darkColor = materialPalette.shade400;

  _RecordActivityWidgetState() {
    locationService.registerObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text(new NumberFormat("##0.00", "en_US").format(activityService.model.totalDistance / 1000.0).toString() + ' km', style: TextStyle(fontSize: 50)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            activityService.currentRanking != null ?
                              '${activityService.currentPosition}/${activityService.currentRanking.ranking.length}' :
                              '',
                            style: TextStyle(fontSize: 50)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: activityService.currentRanking != null ? activityService.currentRanking.ranking.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: activityService.currentRanking.ranking[index].currentResult ? mediumColor : lightColor,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          _prepareColumn('${(index + 1)}.', 14, CrossAxisAlignment.start),
                          _prepareColumn(DateTimeUtils.toDateFormat(activityService.currentRanking.ranking[index].date), 46, CrossAxisAlignment.start),
                          _prepareColumn(activityService.currentRanking.ranking[index].timeText, 40, CrossAxisAlignment.end)
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

  @override
  Future<void> onLocationChanged(LocationPoint locationPoint) async {
    print('Location [ lat: ${locationPoint.latitude}, lng: ${locationPoint.longitude} ]');
    activityService.addLocation(locationPoint);
    print('$apiUrl/activity/ranking/$activityType/${activityService.model.totalDistance}');
    final response = await http.get('$apiUrl/activity/ranking/$activityType/${activityService.model.totalDistance}');
    setState(() {
      activityService.currentRanking = _addListViewFields(_addCurrentResult(ActivityRanking.fromJson(json.decode(response.body))));
    });
//    activityService.model.totalDistance = activityService.getActivityMovingTime() * 6.5;
  }

  ActivityRanking _addCurrentResult(ActivityRanking ranking) {
    final ActivityRankingItem currentResult = new ActivityRankingItem.current(
        DateTimeUtils.toDateFormatFromDate(new DateTime.now()),
        'Ride',
        new DateTime.now().toIso8601String(),
        activityService.getActivityMovingTime(),
        true);
    final int currentResultIndex = _getCurrentResultIndex(ranking, currentResult);
    activityService.currentPosition = currentResultIndex + 1;
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
