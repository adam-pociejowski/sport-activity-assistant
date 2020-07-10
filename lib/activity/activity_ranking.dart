import 'package:flutterapp/activity/activity_ranking_item.dart';

class ActivityRanking {
  final List<ActivityRankingItem> ranking;
  final String activityType;

  ActivityRanking({
    this.ranking,
    this.activityType
  });

  factory ActivityRanking.fromJson(Map<String, dynamic> json) {
    var ranking = new List<ActivityRankingItem>();
    json['ranking'].forEach((item) {
      ranking.add(ActivityRankingItem.fromJson(item));
    });
    return ActivityRanking(
      ranking: ranking,
      activityType: json['activityType']
    );
  }
}