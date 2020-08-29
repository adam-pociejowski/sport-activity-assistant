import 'package:flutterapp/race/model/stage.dart';

class RaceInitRequest {
  final String name;
  final double difficulty;
  final List<Stage> stages;
  final int ridersAmount;
  final String activityType;
  final double riderRaceConditionVariability;
  final double riderCurrentConditionVariability;
  final double maxRiderCurrentConditionChangePerEvent;
  final double randomFactorVariability;
  final double resultsScattering;

  RaceInitRequest({
    this.name,
    this.difficulty,
    this.stages,
    this.ridersAmount,
    this.activityType,
    this.riderRaceConditionVariability,
    this.riderCurrentConditionVariability,
    this.maxRiderCurrentConditionChangePerEvent,
    this.randomFactorVariability,
    this.resultsScattering
  });

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "difficulty": this.difficulty,
      "ridersAmount": this.ridersAmount,
      "stages": this.stages
        .map((stage) => {
          "distance": stage.distance,
          "abilitiesFactor": {
            "flat": stage.abilitiesFactor.flat,
            "mountain": stage.abilitiesFactor.mountain,
            "hill": stage.abilitiesFactor.hill,
            "timeTrial": stage.abilitiesFactor.timeTrial,
          },
          "activityType": stage.activityType.toString(),
        }).toList(),
      "activityType": this.activityType,
      "riderRaceConditionVariability": this.riderRaceConditionVariability,
      "riderCurrentConditionVariability": this.riderCurrentConditionVariability,
      "maxRiderCurrentConditionChangePerEvent": this.maxRiderCurrentConditionChangePerEvent,
      "randomFactorVariability": this.randomFactorVariability,
      "resultsScattering": this.resultsScattering
    };
  }
}