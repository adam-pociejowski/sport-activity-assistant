import 'package:flutterapp/race/model/race_init_request.dart';
import 'package:flutterapp/race/model/stage.dart';

class RaceInitBuilder {
  String _name;
  double _difficulty;
  List<Stage> _stages;
  int _ridersAmount;
  String _activityType;
  double _riderRaceConditionVariability;
  double _riderCurrentConditionVariability;
  double _maxRiderCurrentConditionChangePerEvent;
  double _randomFactorVariability;
  double _resultsScattering;

  RaceInitRequest build() {
    return new RaceInitRequest(
        name: _name,
        difficulty: _difficulty,
        stages: _stages,
        ridersAmount: _ridersAmount,
        activityType: _activityType,
        riderRaceConditionVariability: _riderRaceConditionVariability,
        riderCurrentConditionVariability: _riderCurrentConditionVariability,
        maxRiderCurrentConditionChangePerEvent: _maxRiderCurrentConditionChangePerEvent,
        randomFactorVariability: _randomFactorVariability,
        resultsScattering: _resultsScattering);
  }

  RaceInitBuilder name(String value) {
    _name = value;
    return this;
  }

  RaceInitBuilder difficulty(double value) {
    _difficulty = value;
    return this;
  }

  RaceInitBuilder addStage(Stage value) {
    if (_stages.isEmpty) {
      _stages = [];
    }
    _stages.add(value);
    return this;
  }

  RaceInitBuilder ridersAmount(int value) {
    _ridersAmount = value;
    return this;
  }

  RaceInitBuilder activityType(String value) {
    _activityType = value;
    return this;
  }

  RaceInitBuilder riderRaceConditionVariability(double value) {
    _riderRaceConditionVariability = value;
    return this;
  }

  RaceInitBuilder riderCurrentConditionVariability(double value) {
    _riderCurrentConditionVariability = value;
    return this;
  }

  RaceInitBuilder maxRiderCurrentConditionChangePerEvent(double value) {
    _maxRiderCurrentConditionChangePerEvent = value;
    return this;
  }

  RaceInitBuilder randomFactorVariability(double value) {
    _randomFactorVariability = value;
    return this;
  }

  RaceInitBuilder resultsScattering(double value) {
    _resultsScattering = value;
    return this;
  }
}
