import 'package:json_annotation/json_annotation.dart';
part 'race_config.g.dart';

@JsonSerializable()
class RaceConfig {
  final String raceId;

  RaceConfig(this.raceId);

  factory RaceConfig.fromJson(Map<String, dynamic> json) => _$RaceConfigFromJson(json);

  Map<String, dynamic> toJson() => _$RaceConfigToJson(this);
}