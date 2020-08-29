import 'dart:convert';
import 'package:flutterapp/core/enums/activity_type.dart';
import 'package:flutterapp/core/enums/ranking_type.dart';
import 'package:flutterapp/core/model/activity_ranking.dart';
import 'package:flutterapp/race/model/race_config.dart';
import 'package:flutterapp/race/model/race_init_request.dart';
import 'package:flutterapp/race/model/update_race_request.dart';
import 'package:flutterapp/core/utils/http_utils.dart';
import 'package:global_configuration/global_configuration.dart';

class RaceRestService {
  final apiUrl = GlobalConfiguration().getString("sport_activity_api_url");

  Future<RaceConfig> createRace(RaceInitRequest request) async {
    print('[CREATE RACE]: name: ${request.name}');
    return RaceConfig.fromJson(json.decode((await HttpUtils.post('$apiUrl/race/init', request))));
  }

  Future<String> startStage(String raceId, String stageId) {
    print('[START STAGE]: raceId: $raceId, stageId: $stageId');
    return HttpUtils.get('$apiUrl/race/$raceId/stage/$stageId/start');
  }

  Future<ActivityRanking> simulateRaceStage(UpdateRaceRequest request) async {
    print('[SIMULATE STAGE]: distance: ${request.distance}, raceId: ${request.raceId}');
    return ActivityRanking
        .fromJson(json.decode((await HttpUtils.post('$apiUrl/race/update', request))));
  }

  Future<ActivityRanking> getRaceRanking(String raceId, String stageId, RankingType rankingType) async {
    print('[GET RANKING]: rankingType: $rankingType, raceId: $raceId, stageId: $stageId');
    return ActivityRanking
        .fromJson(json.decode((await HttpUtils.get("$apiUrl/ranking/$raceId/$stageId/$rankingType"))));
  }

  Future<ActivityRanking> getPlayerHistoryRanking(ActivityType activityType, double distance) async {
    print('[GET PLAYER HISTORY RANKING]: activityType: $activityType, distance: $distance');
    return ActivityRanking
        .fromJson(json.decode((await HttpUtils.get('$apiUrl/activity/ranking/$activityType/$distance'))));
  }

  Future<List<RaceConfig>> getAllRaces() async {
    final Iterable iterable = json.decode(await HttpUtils.get('$apiUrl/race/list'));
    final List<RaceConfig> races = iterable
        .map((model) => RaceConfig.fromJson(model))
        .toList();
    races.sort((RaceConfig c1, RaceConfig c2) => c2.generateDate.compareTo(c1.generateDate));
    return races;
  }
}