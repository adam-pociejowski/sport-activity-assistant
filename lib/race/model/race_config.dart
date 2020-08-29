import 'package:flutterapp/race/model/stage_config.dart';
import 'package:json_annotation/json_annotation.dart';
part 'race_config.g.dart';

@JsonSerializable()
class RaceConfig {
  final String raceId;
  final String name;
  final String generateDate;
  final String startDate;
  final String status;
  final double difficulty;
  final List<StageConfig> stages;

  RaceConfig(this.raceId, this.name, this.generateDate, this.startDate, this.status, this.difficulty, this.stages);

  factory RaceConfig.fromJson(Map<String, dynamic> json) => _$RaceConfigFromJson(json);

  Map<String, dynamic> toJson() => _$RaceConfigToJson(this);
}