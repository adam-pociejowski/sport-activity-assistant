import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/service/location/location_observer.dart';
import 'package:flutterapp/service/player_activity_service.dart';
import 'package:flutterapp/util/datetime_utils.dart';
import 'package:flutterapp/widget/record_activity_widget.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'location/location_service.dart';

abstract class AbstractActivityLocationObserver implements LocationObserver {
  final apiUrl = GlobalConfiguration().getString("sport_activity_api_url");
  final playerActivityService = new PlayerActivityService();
  RecordActivityWidgetState state;
  var activityType = 'outdoor_ride';

  AbstractActivityLocationObserver() {
    LocationService
        .INSTANCE
        .registerObserver(this);
  }

  RecordActivityWidgetModel mapToModel(Response response);

  void afterLocationChanged(LocationPoint locationPoint);

  Future<void> onLocationChanged(LocationPoint locationPoint) async {
    print('Location [ lat: ${locationPoint.latitude}, lng: ${locationPoint.longitude} ]');
    playerActivityService.addLocation(locationPoint);
    this.afterLocationChanged(locationPoint);
  }

  void registerState(State state) {
    this.state = state;
  }

  void unRegisterState(State state) {
    this.state = null;
  }

  void updateState(RecordActivityWidgetModel model) {
    this.state.updateState(model);
  }

  String formatToLostTimeText(RankingItem leader, RankingItem current) {
    return leader == current ?
        DateTimeUtils.formatTime(leader.timeInSec.round()) :
        '+ ' + DateTimeUtils.formatTime(current.timeInSec.round() - leader.timeInSec.round());
  }
}

class RankingItem {
  final String activityType;
  final String name;
  final double timeInSec;
  final bool isPlayerResult;

  RankingItem(
      this.activityType,
      this.name,
      this.timeInSec,
      this.isPlayerResult);
}