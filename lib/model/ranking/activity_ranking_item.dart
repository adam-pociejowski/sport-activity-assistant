import 'package:json_annotation/json_annotation.dart';
import 'activity_ranking_item_info.dart';
part 'activity_ranking_item.g.dart';

@JsonSerializable()
class ActivityRankingItem {
  final ActivityRankingItemInfo info;
  final String activityType;
  final double timeInSec;

  ActivityRankingItem(
    this.info,
    this.activityType,
    this.timeInSec
  );

  factory ActivityRankingItem.fromJson(Map<String, dynamic> json) => _$ActivityRankingItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRankingItemToJson(this);
}