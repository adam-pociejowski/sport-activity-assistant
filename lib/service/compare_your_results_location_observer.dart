import 'dart:convert';
import 'package:flutterapp/enums/activity_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/model/ranking/activity_ranking.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:flutterapp/util/datetime_utils.dart';
import 'package:http/http.dart' as http;

class CompareYourResultsLocationObserver extends AbstractActivityLocationObserver {

  Future<void> afterLocationChanged(LocationPoint locationPoint) async {
    print('$apiUrl/activity/ranking/$activityType/${playerActivityService.model.totalDistance}');
    playerActivityService.model.totalDistance += 100.0;
    this.updateState(mapToModel((await http.get('$apiUrl/activity/ranking/$activityType/${playerActivityService.model.totalDistance}')).body));
  }

  RecordActivityWidgetModel mapToModel(String responseJson) {
    return new RecordActivityWidgetModel(
        playerActivityService.model.totalDistance / 1000.0,
        playerActivityService.currentPosition,
        prepareSortedRankingItems(responseJson)
    );
  }

  List<RankingItem> afterRankingMap(List<RankingItem> rankingItems) {
    rankingItems.add(new RankingItem(
        activityType: ActivityType.OUTDOOR_RIDE,
        name: DateTime.now().toString(),
        timeInSec: playerActivityService.getActivityMovingTime(),
        isPlayerResult: true
    ));
    return rankingItems;
  }

  List<RankingItem> mapToRankingItems(String responseJson) {
    return ActivityRanking
        .fromJson(json.decode(responseJson))
        .ranking
        .map((item) =>
            new RankingItem(
              activityType: ActivityType.findByName(item.activityType),
              name: DateTimeUtils.toDateFormat(item.info['date']),
              timeInSec: item.timeInSec,
              isPlayerResult: false
            ))
        .toList();
  }
}
