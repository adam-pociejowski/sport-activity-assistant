import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/enums/activity_type.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/model/ranking/activity_ranking.dart';
import 'package:flutterapp/model/simulate/abilities_factor.dart';
import 'package:flutterapp/model/simulate/race_config.dart';
import 'package:flutterapp/model/simulate/race_init_request.dart';
import 'package:flutterapp/model/simulate/stage.dart';
import 'package:flutterapp/model/simulate/update_race_request.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/util/htttp_utils.dart';

class SimulateRaceLocationObserver extends AbstractActivityLocationObserver {
  RaceConfig raceConfig;

  Future<void> init(State state) async {
    super.init(state);
    this.raceConfig = RaceConfig.fromJson(json.decode((await HttpUtils.post(
        '$apiUrl/race/init',
        new RaceInitRequest(
            name: 'Race',
            difficulty: 0.45,
            stages: [
              new Stage(
                distance: 12.2,
                abilitiesFactor: new RiderAbilities(
                  flat: 0.0,
                  mountain: 4.0,
                  hill: 0.0,
                  timeTrial: 0.0,
                ),
                activityType: ActivityType.OUTDOOR_RIDE,
              ),
            ],
            ridersAmount: 100,
            showMyResults: false,
            activityType: ActivityType.OUTDOOR_RIDE.toString(),
            riderRaceConditionVariability: 0.05,
            riderCurrentConditionVariability: 0.2,
            maxRiderCurrentConditionChangePerEvent: 0.02,
            randomFactorVariability: 0.02,
            resultsScattering: 2.0)))));
  }

  Future<void> afterLocationChanged(LocationPoint locationPoint) async {
    print('$apiUrl/race/update, distance: ${playerActivityService.model.totalDistance}, raceId: ${this.raceConfig.raceId}');
//    playerActivityService.model.totalDistance += 100.0;
    var speed = 25.0;
    playerActivityService.model.totalDistance = speed * playerActivityService.getActivityMovingTime() / 3.6;
    this.updateState(mapToModel((await HttpUtils.post(
        '$apiUrl/race/update',
        new UpdateRaceRequest(
            raceId: this.raceConfig.raceId,
            stageId: this.raceConfig.stages[0].stageId,
            location: locationPoint,
            time: playerActivityService.getActivityMovingTime(),
            distance: playerActivityService.model.totalDistance)))));
  }

  RecordActivityWidgetModel mapToModel(String responseJson) {
    return new RecordActivityWidgetModel(playerActivityService.model.totalDistance / 1000.0, playerActivityService.currentPosition, prepareSortedRankingItems(responseJson));
  }

  List<RankingItem> afterRankingMap(List<RankingItem> rankingItems) {
    return rankingItems;
  }

  List<RankingItem> mapToRankingItems(String responseJson) {
    return ActivityRanking.fromJson(json.decode(responseJson))
        .ranking
        .map((item) => new RankingItem(
            activityType: ActivityType.findByName(item.activityType),
            name: item.info['name'],
            type: RankingItemRaceEventType.findByName(item.info['type']),
            country: item.info['country'],
            power: item.info['power'],
            timeInSec: item.timeInSec,
            isPlayerResult: RankingItemRaceEventType.findByName(item.info['type']) == RankingItemRaceEventType.USER_ACTIVITY))
        .toList();
  }
}
