import 'package:flutterapp/enums/activity_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity_ranking_item.g.dart';

@JsonSerializable()
class ActivityRankingItem {
  final Map<String, dynamic> info;
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
