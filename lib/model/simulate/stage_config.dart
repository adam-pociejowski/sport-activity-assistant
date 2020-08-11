import 'package:json_annotation/json_annotation.dart';
part 'stage_config.g.dart';

@JsonSerializable()
class StageConfig {
  final String stageId;

  StageConfig(this.stageId);

  factory StageConfig.fromJson(Map<String, dynamic> json) => _$StageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$StageConfigToJson(this);
}