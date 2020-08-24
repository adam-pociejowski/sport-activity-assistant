import 'package:json_annotation/json_annotation.dart';
part 'stage_config.g.dart';

@JsonSerializable()
class StageConfig {
  final String stageId;
  final double distance;

  StageConfig(this.stageId, this.distance);

  factory StageConfig.fromJson(Map<String, dynamic> json) => _$StageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$StageConfigToJson(this);
}