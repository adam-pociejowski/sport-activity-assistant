import 'package:flutterapp/model/ranking/activity_ranking_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity_ranking.g.dart';

@JsonSerializable()
class ActivityRanking {
  final List<ActivityRankingItem> ranking;
  final String status;
  final double distance;

  ActivityRanking({
    this.ranking,
    this.status,
    this.distance
  });

  factory ActivityRanking.fromJson(Map<String, dynamic> json) => _$ActivityRankingFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRankingToJson(this);
}