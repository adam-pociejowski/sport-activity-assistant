import 'package:json_annotation/json_annotation.dart';
part 'activity_ranking_item_info.g.dart';

@JsonSerializable()
class ActivityRankingItemInfo {
  final String name;
  final String date;

  ActivityRankingItemInfo(this.name, this.date);

  factory ActivityRankingItemInfo.fromJson(Map<String, dynamic> json) => _$ActivityRankingItemInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRankingItemInfoToJson(this);
}