class RaceInitRequest {
  final String name;
  final double difficulty;
  final List<double> stagesDistance;
  final int ridersAmount;
  final bool showMyResults;
  final String activityType;
  final double raceConditionMin;
  final double raceConditionMax;

  RaceInitRequest({
    this.name,
    this.difficulty,
    this.stagesDistance,
    this.ridersAmount,
    this.showMyResults,
    this.activityType,
    this.raceConditionMin,
    this.raceConditionMax
  });

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "difficulty": this.difficulty,
      "ridersAmount": this.ridersAmount,
      "stagesDistance": this.stagesDistance,
      "showMyResults": this.showMyResults,
      "activityType": this.activityType,
      "raceConditionMin": this.raceConditionMin,
      "raceConditionMax": this.raceConditionMax,
    };
  }
}