import 'package:flutterapp/record_activity/model/activity_model.dart';
import 'package:flutterapp/record_activity/model/activity_pause.dart';
import 'package:flutterapp/location/model/location_point.dart';
import 'package:flutterapp/location/utils/location_utils.dart';
import 'package:flutterapp/core/utils/datetime_utils.dart';
import 'package:global_configuration/global_configuration.dart';

class RecordActivityService {
  var minRequiredDistanceChange = GlobalConfiguration().getDouble("min_location_distance_change_in_meters_required");
  ActivityModel model = new ActivityModel();

  double getActivityMovingTime() {
    return ((new DateTime.now().millisecondsSinceEpoch - model.activityStartDate.millisecondsSinceEpoch - model.totalPauseTime) / 1000)
        .toDouble();
  }

  double addLocation(LocationPoint currentLocation) {
    if (model.locations.isNotEmpty) {
      var distanceFromLastPoint = LocationUtils.getDistanceBetweenLocationsInMeters(model.locations.last, currentLocation);
      var isCurrentlyActivityPaused = _isCurrentlyActivityPaused();
      var hasLocationChangedSinceLastPoint = _hasLocationChangedSinceLastPoint(distanceFromLastPoint);
      if (_isStillActivityPaused(isCurrentlyActivityPaused, hasLocationChangedSinceLastPoint)) {
        _updateActivityPause(currentLocation);
      } else if (_isActivityPauseStarted(isCurrentlyActivityPaused, hasLocationChangedSinceLastPoint)) {
        model.pauses.add(new ActivityPause());
        _updateActivityPause(currentLocation);
      } else {
        model.totalDistance += distanceFromLastPoint;
      }
    }
    model.locations.add(currentLocation);
    return model.totalDistance;
  }

  void _updateActivityPause(LocationPoint currentLocation) {
    int timeDiff = DateTimeUtils.getTimeDiff(currentLocation.time, model.locations.last.time);
    model.pauses.last.pauseTime += timeDiff;
    model.totalPauseTime += timeDiff;
    model.pauses.last.locations.add(currentLocation);
  }

  bool _isActivityPauseStarted(bool isCurrentlyActivityPaused, bool hasLocationChangedSinceLastPoint) =>
      !isCurrentlyActivityPaused && !hasLocationChangedSinceLastPoint;

  bool _isStillActivityPaused(bool isCurrentlyActivityPaused, bool hasLocationChangedSinceLastPoint) =>
      isCurrentlyActivityPaused && !hasLocationChangedSinceLastPoint;

  bool _hasLocationChangedSinceLastPoint(double distanceFromLastPoint) =>
      distanceFromLastPoint >= minRequiredDistanceChange;
  
  bool _isCurrentlyActivityPaused() =>
      model.pauses.isNotEmpty &&
          model.locations.last == model.pauses.last.locations.last;

}