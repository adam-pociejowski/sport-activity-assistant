class RaceInitRequest {
  final String name;
  final double difficulty;
  final List<double> stagesDistance;
  final int ridersAmount;
  final bool showMyResults;
  final String activityType;
  final double riderRaceConditionVariability;
  final double riderCurrentConditionVariability;
  final double maxRiderCurrentConditionChangePerEvent;
  final double randomFactorVariability;

  RaceInitRequest({
    this.name,
    this.difficulty,
    this.stagesDistance,
    this.ridersAmount,
    this.showMyResults,
    this.activityType,
    this.riderRaceConditionVariability,
    this.riderCurrentConditionVariability,
    this.maxRiderCurrentConditionChangePerEvent,
    this.randomFactorVariability
  });

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "difficulty": this.difficulty,
      "ridersAmount": this.ridersAmount,
      "stagesDistance": this.stagesDistance,
      "showMyResults": this.showMyResults,
      "activityType": this.activityType,
      "riderRaceConditionVariability": this.riderRaceConditionVariability,
      "riderCurrentConditionVariability": this.riderCurrentConditionVariability,
      "maxRiderCurrentConditionChangePerEvent": this.maxRiderCurrentConditionChangePerEvent,
      "randomFactorVariability": this.randomFactorVariability
    };
  }
}