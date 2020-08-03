import 'dart:convert';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/model/ranking/activity_ranking.dart';
import 'package:flutterapp/service/abstract_activity_location_observer.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CompareYourResultsLocationObserver extends AbstractActivityLocationObserver {
  CompareYourResultsLocationObserver() {
    activityType = 'outdoor_ride';
  }

  Future<void> afterLocationChanged(LocationPoint locationPoint) async {
    print('$apiUrl/activity/ranking/$activityType/${playerActivityService.model.totalDistance}');
    playerActivityService.model.totalDistance += 100.0;
    this.updateState(mapToModel((await http.get('$apiUrl/activity/ranking/$activityType/${playerActivityService.model.totalDistance}'))));
  }

  RecordActivityWidgetModel mapToModel(Response response) {
    return new RecordActivityWidgetModel(
        playerActivityService.model.totalDistance / 1000.0,
        playerActivityService.currentPosition,
        _prepareSortedRankingItems(response)
    );
  }

  List<RecordActivityWidgetRankingItem> _prepareSortedRankingItems(Response response) {
    final List<RankingItem> rankingItems = _mapToRankingItems(response);
    rankingItems.add(new RankingItem('Ride', DateTime.now().toString(), playerActivityService.getActivityMovingTime(), true));
    rankingItems.sort((RankingItem o1, RankingItem o2) => o1.timeInSec.compareTo(o2.timeInSec));
    return rankingItems
        .map((item) =>
            new RecordActivityWidgetRankingItem(
                item.activityType,
                item.isPlayerResult,
                formatToLostTimeText(rankingItems[0], item),
                item.name))
        .toList();
  }

  List<RankingItem> _mapToRankingItems(Response response) {
    return ActivityRanking
        .fromJson(json.decode(response.body))
        .ranking
        .map((item) =>
            new RankingItem(
                item.activityType,
                item.info.date,
                item.timeInSec,
                false))
        .toList();
  }
}
