import 'dart:convert';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/model/ranking/activity_ranking.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:http/http.dart' as http;

class CompareYourResultsLocationObserver extends AbstractActivityLocationObserver {

  CompareYourResultsLocationObserver() {
    activityType = 'outdoor_ride';
  }

  Future<void> afterLocationChanged(LocationPoint locationPoint) async {
    print('$apiUrl/activity/ranking/$activityType/${playerActivityService.model.totalDistance}');
    final response = await http.get('$apiUrl/activity/ranking/$activityType/${playerActivityService.model.totalDistance}');
    this.updateState(
        ActivityRanking
            .fromJson(json.decode(response.body)));
  }
}