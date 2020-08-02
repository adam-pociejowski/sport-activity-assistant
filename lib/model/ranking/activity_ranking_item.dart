import 'package:json_annotation/json_annotation.dart';
import 'activity_ranking_item_info.dart';
part 'activity_ranking_item.g.dart';

@JsonSerializable()
class ActivityRankingItem {
  int position;
  final ActivityRankingItemInfo info;
  final String activityType;
  final double timeInSec;
  bool currentResult = false;
  String timeText;

  ActivityRankingItem({
    this.position,
    this.info,
    this.activityType,
    this.timeInSec,
  });

  ActivityRankingItem.current(
    this.info,
    this.activityType,
    this.timeInSec,
    this.currentResult
  );

  factory ActivityRankingItem.fromJson(Map<String, dynamic> json) => _$ActivityRankingItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRankingItemToJson(this);
}