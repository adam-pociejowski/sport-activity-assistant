import 'package:flutterapp/record_activity/activity_ranking_item.dart';

class ActivityRanking {
  final List<ActivityRankingItem> ranking;
  final double distance;
  final String activityType;

  ActivityRanking({
    this.ranking,
    this.distance,
    this.activityType
  });

  factory ActivityRanking.fromJson(Map<String, dynamic> json) {
    var ranking = new List<ActivityRankingItem>();
    json['ranking'].forEach((item) {
      ranking.add(ActivityRankingItem.fromJson(item));
    });
    return ActivityRanking(
      ranking: ranking,
      distance: json['distance'],
      activityType: json['activityType']
    );
  }
}