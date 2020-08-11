import 'package:flutterapp/model/activity/activity_pause.dart';
import 'package:flutterapp/model/location/location_point.dart';

class ActivityModel {
  int totalPauseTime = 0;
  int totalMovingTime = 0;
  double totalDistance = 0.0;
  DateTime activityStartDate = new DateTime.now();
  List<LocationPoint> locations = new List<LocationPoint>();
  List<ActivityPause> pauses = new List<ActivityPause>();
}