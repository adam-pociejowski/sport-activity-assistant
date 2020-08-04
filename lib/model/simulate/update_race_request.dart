import 'package:flutterapp/model/location/location_point.dart';

class UpdateRaceRequest {
  final String raceId;
  final String stageId;
  final LocationPoint location;
  final double time;
  final double distance;

  UpdateRaceRequest({
    this.raceId,
    this.stageId,
    this.location,
    this.time,
    this.distance
  });

  Map<String, dynamic> toJson() {
    return {
      "raceId": this.raceId,
      "stageId": this.stageId,
      "location": {
        "latitude": this.location.latitude,
        "longitude": this.location.longitude,
        "altitude": this.location.altitude,
        "accuracy": this.location.accuracy
      },
      "time": this.time,
      "distance": this.distance
    };
  }
}