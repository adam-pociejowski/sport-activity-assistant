import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/enums/activity_type.dart';
import 'package:flutterapp/enums/race_status.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/model/ranking/activity_ranking.dart';
import 'package:flutterapp/model/simulate/abilities_factor.dart';
import 'package:flutterapp/model/simulate/race_config.dart';
import 'package:flutterapp/model/simulate/race_init_request.dart';
import 'package:flutterapp/model/simulate/stage.dart';
import 'package:flutterapp/model/simulate/stage_config.dart';
import 'package:flutterapp/model/simulate/update_race_request.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/util/http_utils.dart';

class SimulateRaceLocationObserver extends AbstractActivityLocationObserver {
  RaceConfig raceConfig;
  StageConfig stageConfig;

  SimulateRaceLocationObserver(RaceConfig raceConfig) {
    this.raceConfig = raceConfig;
  }

  Future<void> init(State state) async {
    super.init(state);
    if (raceConfig == null) {
      raceConfig = await _initRace();
    }
    stageConfig = _findCurrentStage(raceConfig);
    await HttpUtils.get('$apiUrl/race/${raceConfig.raceId}/stage/${stageConfig.stageId}/start');
  }

  StageConfig _findCurrentStage(RaceConfig raceConfig) {
    return raceConfig
        .stages
        .where((element) => RaceStatus.findByName(element.status) != RaceStatus.FINISHED)
        .first;
  }

  Future<RaceConfig> _initRace() async {
    return RaceConfig.fromJson(json.decode((await HttpUtils.post(
        '$apiUrl/race/init',
        new RaceInitRequest(
            name: 'Race',
            difficulty: 0.55,
            stages: [
              new Stage(
                distance: 3000.0,
                abilitiesFactor: new RiderAbilities(
                  flat: 0.0,
                  mountain: 0.0,
                  hill: 0.0,
                  timeTrial: 2.0,
                ),
                activityType: ActivityType.OUTDOOR_RIDE,
              ),
              new Stage(
                distance: 12000.0,
                abilitiesFactor: new RiderAbilities(
                  flat: 0.0,
                  mountain: 0.7,
                  hill: 0.8,
                  timeTrial: 0.0,
                ),
                activityType: ActivityType.OUTDOOR_RIDE,
              ),
              new Stage(
                distance: 15000.0,
                abilitiesFactor: new RiderAbilities(
                  flat: 0.0,
                  mountain: 1.7,
                  hill: 0.0,
                  timeTrial: 0.0,
                ),
                activityType: ActivityType.OUTDOOR_RIDE,
              ),
            ],
            ridersAmount: 100,
            activityType: ActivityType.OUTDOOR_RIDE.toString(),
            riderRaceConditionVariability: 0.04,
            riderCurrentConditionVariability: 0.1,
            maxRiderCurrentConditionChangePerEvent: 0.015,
            randomFactorVariability: 0.02,
            resultsScattering: 1.0)))));
  }

  Future<void> afterLocationChanged(LocationPoint locationPoint) async {
    print('$apiUrl/race/update, distance: ${playerActivityService.model.totalDistance}, raceId: ${this.raceConfig.raceId}');
    if (profile == "dev") {
      var speed = 29.0;
      playerActivityService.model.totalDistance = speed * playerActivityService.getActivityMovingTime() / 3.6;
    }
    final ActivityRanking activityRanking = ActivityRanking.fromJson(json.decode((await HttpUtils.post(
        '$apiUrl/race/update',
        new UpdateRaceRequest(
            raceId: this.raceConfig.raceId,
            stageId: this.stageConfig.stageId,
            location: locationPoint,
            time: playerActivityService.getActivityMovingTime(),
            distance: playerActivityService.model.totalDistance,
            rankingType: this.rankingType)))));
    var model = mapToModel(activityRanking);
    this.updateState(model);
    if (RaceStatus.findByName(activityRanking.status) == RaceStatus.FINISHED) {
      this.finish(model);
    }
  }

  RecordActivityWidgetModel mapToModel(ActivityRanking activityRanking) {
    final List<RecordActivityWidgetRankingItem> ranking = prepareSortedRankingItems(activityRanking);
    final RecordActivityWidgetRankingItem playerItem = ranking.firstWhere((item) => item.itemType == RankingItemRaceEventType.USER_ACTIVITY);
    return new RecordActivityWidgetModel(
        playerActivityService.model.totalDistance / 1000.0,
        stageConfig.distance / 1000.0,
        playerItem == null ? 1 : ranking.indexOf(playerItem) + 1,
        RaceStatus.findByName(activityRanking.status), ranking);
  }

  List<RankingItem> afterRankingMap(List<RankingItem> rankingItems) {
    return rankingItems;
  }

  List<RankingItem> mapToRankingItems(ActivityRanking activityRanking) {
    return activityRanking.ranking
        .map((item) => new RankingItem(
            activityType: ActivityType.findByName(item.activityType),
            name: item.info['name'],
            type: RankingItemRaceEventType.findByName(item.info['type']),
            country: item.info['country'],
            power: item.info['power'],
            timeInSec: item.timeInSec))
        .toList();
  }

  Future<void> afterUpdateRankingType() async {
    final ActivityRanking activityRanking = ActivityRanking
        .fromJson(
              json.decode(
                  (await HttpUtils.get("$apiUrl/ranking/${raceConfig.raceId}/${stageConfig.stageId}/${rankingType}"))));
    this.updateState(mapToModel(activityRanking));
  }
}
