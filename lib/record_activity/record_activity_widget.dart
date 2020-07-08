import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/location/location_observer.dart';
import 'package:flutterapp/location/location_service.dart';
import 'package:flutterapp/record_activity/activity_ranking.dart';
import 'package:flutterapp/record_activity/activity_ranking_item.dart';
import 'package:flutterapp/record_activity/activity_service.dart';
import 'package:flutterapp/util/datetime_utils.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class RecordActivityWidget extends StatefulWidget {
  @override
  _RecordActivityWidgetState createState() => _RecordActivityWidgetState();
}

class _RecordActivityWidgetState extends State<RecordActivityWidget> implements LocationObserver {
  var locationService = new LocationService();
  var activityService = new ActivityService();
  var apiUrl = 'https://api-sportactivity.apociejowski.pl';
  ActivityRanking _currentRanking;
  double distance = 10.14;

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
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _currentRanking != null ? _currentRanking.ranking.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    _prepareColumn((index + 1).toString(), 14, CrossAxisAlignment.start),
                    _prepareColumn(DateTimeUtils.toDateFormat(_currentRanking.ranking[index].date), 50, CrossAxisAlignment.start),
                    _prepareColumn(_currentRanking.ranking[index].timeText, 36, CrossAxisAlignment.end)
                  ],
                ),
              ),
            );
          },
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
          Text(
            text,
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onLocationChanged(LocationData locationData) async {
    print('Location [ lat: ${locationData.latitude}, lng: ${locationData.longitude} ]');
    activityService.addLocation(locationData);
    var response = await http.get(apiUrl + '/rest/activity/ranking/outdoor_ride/'+distance.toString());
    setState(() {
      _currentRanking = _addListViewFields(_addCurrentResult(ActivityRanking.fromJson(json.decode(response.body)), new ActivityRankingItem()));
    });
    distance += 50.11;
  }

  ActivityRanking _addCurrentResult(ActivityRanking ranking, ActivityRankingItem currentResult) {
    return ranking;
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
