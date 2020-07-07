import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/location/location_observer.dart';
import 'package:flutterapp/location/location_service.dart';
import 'package:flutterapp/record_activity/activity_ranking.dart';
import 'package:flutterapp/record_activity/activity_ranking_item.dart';
import 'package:flutterapp/record_activity/activity_service.dart';
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
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
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
          itemCount: _currentRanking.ranking.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[_prepareColumn(_currentRanking.ranking[index].activityName), _prepareColumn(_currentRanking.ranking[index].timeText)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Expanded _prepareColumn(String text) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 16),
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
          element.timeText = _formatTime(bestResult.timeInSec.round());
        } else {
          element.timeText = '+ ' + _formatTime(element.timeInSec.round() - bestResult.timeInSec.round());
        }
      });
    }
    return ranking;
  }

  _formatTime(int timeInSec) {
    var hours = (timeInSec ~/ 3600).toString();
    timeInSec %= 3600;
    var minutes = _formatMinutes(hours, timeInSec ~/ 60);
    timeInSec %= 60;
    var seconds = _formatSeconds(timeInSec);
    return _prepareFinalTimeText(hours, minutes, seconds);
  }

  _formatMinutes(String hours, int minutes) {
    if (hours == '0') {
      return minutes.toString();
    }
    return minutes >= 10 ? minutes.toString() : '0' + minutes.toString();
  }

  _formatSeconds(int timeMetric) {
    if (timeMetric >= 10) {
      return timeMetric.toString();
    } else if (timeMetric > 0) {
      return '0' + timeMetric.toString();
    }
    return '00';
  }

  _prepareFinalTimeText(String hours, String minutes, String seconds) {
    if (hours == '0') {
      if (minutes == '00') {
        return seconds;
      }
      return minutes + ':' + seconds;
    }
    return hours + ':' + minutes + ':' + seconds;
  }
}
