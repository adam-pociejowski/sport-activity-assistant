import 'package:json_annotation/json_annotation.dart';
part 'stage_config.g.dart';

@JsonSerializable()
class StageConfig {
  final String stageId;
  final double distance;
  final String status;

  StageConfig(this.stageId, this.distance, this.status);

  factory StageConfig.fromJson(Map<String, dynamic> json) => _$StageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$StageConfigToJson(this);
}