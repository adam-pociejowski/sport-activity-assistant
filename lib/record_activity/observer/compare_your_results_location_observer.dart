import 'package:flutterapp/core/enums/activity_type.dart';
import 'package:flutterapp/core/enums/race_status.dart';
import 'package:flutterapp/core/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/record_activity/model/record_activity_widget_model.dart';
import 'package:flutterapp/location/model/location_point.dart';
import 'package:flutterapp/core/model/activity_ranking.dart';
import 'package:flutterapp/record_activity/observer/abstract_activity_location_observer.dart';
import 'package:flutterapp/core/utils/datetime_utils.dart';

class CompareYourResultsLocationObserver extends AbstractActivityLocationObserver {

  Future<void> afterLocationChanged(LocationPoint locationPoint) async {
    playerActivityService.model.totalDistance += 100.0;
    this.updateState(
        mapToModel((await this.raceRestService.getPlayerHistoryRanking(activityType, playerActivityService.model.totalDistance))));
  }

  RecordActivityWidgetModel mapToModel(ActivityRanking activityRanking) {
    return new RecordActivityWidgetModel(
        playerActivityService.model.totalDistance / 1000.0,
        10.1,
        1,
        RaceStatus.findByName(activityRanking.status),
        prepareSortedRankingItems(activityRanking)
    );
  }

  List<RankingItem> afterRankingMap(List<RankingItem> rankingItems) {
    rankingItems.add(new RankingItem(
        activityType: ActivityType.OUTDOOR_RIDE,
        name: DateTime.now().toString(),
        timeInSec: playerActivityService.getActivityMovingTime(),
        type: RankingItemRaceEventType.USER_ACTIVITY
    ));
    return rankingItems;
  }

  List<RankingItem> mapToRankingItems(ActivityRanking activityRanking) {
    return activityRanking
        .ranking
        .map((item) =>
            new RankingItem(
               activityType: ActivityType.findByName(item.activityType),
                name: DateTimeUtils.toDateFormat(item.info['date']),
                timeInSec: item.timeInSec,
                type: RankingItemRaceEventType.NPC
            ))
        .toList();
  }

  void afterUpdateRankingType() {}
}
