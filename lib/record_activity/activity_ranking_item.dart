class ActivityRankingItem {
  int position;
  final String activityName;
  final String stravaActivityType;
  final String date;
  final double timeInSec;
  double avgSpeed;
  bool currentResult = false;
  String timeText;

  ActivityRankingItem({
    this.position,
    this.activityName,
    this.stravaActivityType,
    this.date,
    this.timeInSec,
    this.avgSpeed
  });

  ActivityRankingItem.current(
    this.activityName,
    this.stravaActivityType,
    this.date,
    this.timeInSec,
    this.currentResult
  );

  factory ActivityRankingItem.fromJson(Map<String, dynamic> json) {
    return ActivityRankingItem(
      position: json['position'],
      activityName: json['activityName'],
      stravaActivityType: json['stravaActivityType'],
      date: json['date'],
      timeInSec: json['timeInSec'],
      avgSpeed: json['avgSpeed'],
    );
  }
}