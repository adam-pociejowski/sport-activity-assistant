import 'package:flutterapp/model/simulate/stage_config.dart';
import 'package:json_annotation/json_annotation.dart';
part 'race_config.g.dart';

@JsonSerializable()
class RaceConfig {
  final String raceId;
  final List<StageConfig> stages;

  RaceConfig(this.raceId, this.stages);

  factory RaceConfig.fromJson(Map<String, dynamic> json) => _$RaceConfigFromJson(json);

  Map<String, dynamic> toJson() => _$RaceConfigToJson(this);
}