import 'package:flutterapp/activity/activity_model.dart';
import 'package:flutterapp/activity/activity_pause.dart';
import 'package:flutterapp/location/location_point.dart';
import 'package:flutterapp/location/location_utils.dart';
import 'package:flutterapp/util/datetime_utils.dart';
import 'package:global_configuration/global_configuration.dart';
import 'activity_ranking.dart';

class ActivityService {
  var minRequiredDistanceChange = GlobalConfiguration().getDouble("min_location_distance_change_in_meters_required");
  ActivityRanking currentRanking;
  var currentPosition = 1;
  ActivityModel model = new ActivityModel();

  double getActivityMovingTime() {
    return ((new DateTime.now().millisecondsSinceEpoch - model.activityStartDate.millisecondsSinceEpoch - model.totalPauseTime) / 1000)
        .toDouble();
  }

  double addLocation(LocationPoint currentLocation) {
    if (model.locations.isNotEmpty) {
      var distanceFromLastPoint = LocationUtils.getDistanceBetweenLocationsInMeters(model.locations.last, currentLocation);
      print('distanceFromLastPoint: $distanceFromLastPoint ${currentLocation.time}');
      var isCurrentlyActivityPaused = _isCurrentlyActivityPaused();
      var hasLocationChangedSinceLastPoint = _hasLocationChangedSinceLastPoint(distanceFromLastPoint);
      if (_isStillActivityPaused(isCurrentlyActivityPaused, hasLocationChangedSinceLastPoint)) {
        _updateActivityPause(currentLocation);
        print('still paused');
      } else if (_isActivityPauseStarted(isCurrentlyActivityPaused, hasLocationChangedSinceLastPoint)) {
        model.pauses.add(new ActivityPause());
        _updateActivityPause(currentLocation);
        print('start of pause');
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