import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/service/location/location_observer.dart';
import 'package:flutterapp/service/player_activity_service.dart';
import 'package:flutterapp/widget/record_activity_widget.dart';
import 'package:global_configuration/global_configuration.dart';
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
}