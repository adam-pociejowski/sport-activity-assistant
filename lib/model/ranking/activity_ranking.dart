import 'package:flutterapp/model/ranking/activity_ranking_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity_ranking.g.dart';

@JsonSerializable()
class ActivityRanking {
  final List<ActivityRankingItem> ranking;
  final String activityType;

  ActivityRanking({
    this.ranking,
    this.activityType
  });

  factory ActivityRanking.fromJson(Map<String, dynamic> json) => _$ActivityRankingFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRankingToJson(this);
}