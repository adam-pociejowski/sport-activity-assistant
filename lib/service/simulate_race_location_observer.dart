import 'dart:convert';
import 'package:flutterapp/enums/activity_type.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/model/ranking/activity_ranking.dart';
import 'package:flutterapp/model/simulate/race_config.dart';
import 'package:flutterapp/model/simulate/race_init_request.dart';
import 'package:flutterapp/model/simulate/update_race_request.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/util/htttp_utils.dart';

class SimulateRaceLocationObserver extends AbstractActivityLocationObserver {
  RaceConfig raceConfig;

  Future<void> init() async {
    print('SimulateRaceLocationObserver initialized');
    this.raceConfig = RaceConfig
        .fromJson(
        json
            .decode(
            (await HttpUtils.post(
                '$apiUrl/race/init',
                new RaceInitRequest(
                    name: 'Race',
                    difficulty: 0.5,
                    stagesDistance: [ 1000.12 ],
                    ridersAmount: 10,
                    showMyResults: false,
                    activityType: ActivityType.OUTDOOR_RIDE.toString(),
                    raceConditionMin: 0.95,
                    raceConditionMax: 1.0
                )))));
  }

  Future<void> afterLocationChanged(LocationPoint locationPoint) async {
    print('$apiUrl/race/update, distance: ${playerActivityService.model.totalDistance}');
    playerActivityService.model.totalDistance += 100.0;
    this.updateState(
        mapToModel(
          (await HttpUtils.post(
              '$apiUrl/race/update',
              new UpdateRaceRequest(
                  raceId: this.raceConfig.raceId,
                  stageId: null,
                  location: locationPoint,
                  time: playerActivityService.getActivityMovingTime(),
                  distance: playerActivityService.model.totalDistance
              )))));
  }

  RecordActivityWidgetModel mapToModel(String responseJson) {
    return new RecordActivityWidgetModel(
        playerActivityService.model.totalDistance / 1000.0,
        playerActivityService.currentPosition,
        prepareSortedRankingItems(responseJson)
    );
  }

  List<RankingItem> afterRankingMap(List<RankingItem> rankingItems) {
    return rankingItems;
  }

  List<RankingItem> mapToRankingItems(String responseJson) {
    return ActivityRanking
        .fromJson(json.decode(responseJson))
        .ranking
        .map((item) =>
            new RankingItem(
                activityType: ActivityType.findByName(item.activityType),
                name: item.info['name'],
                type: RankingItemRaceEventType.findByName(item.info['type']),
                country: item.info['country'],
                timeInSec: item.timeInSec,
                isPlayerResult: RankingItemRaceEventType.findByName(item.info['type']) == RankingItemRaceEventType.USER_ACTIVITY
            ))
        .toList();
  }
}
