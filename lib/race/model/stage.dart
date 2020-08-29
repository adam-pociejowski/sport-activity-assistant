import 'package:flutterapp/core/enums/activity_type.dart';
import 'abilities_factor.dart';

class Stage {
  final double distance;
  final RiderAbilities abilitiesFactor;
  final ActivityType activityType;

  Stage({this.distance, this.abilitiesFactor, this.activityType});
}