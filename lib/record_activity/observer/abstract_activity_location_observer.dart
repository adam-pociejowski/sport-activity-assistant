import 'package:flutter/cupertino.dart';
import 'package:flutterapp/core/enums/activity_type.dart';
import 'package:flutterapp/core/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/core/enums/ranking_type.dart';
import 'package:flutterapp/race/service/race_rest_service.dart';
import 'package:flutterapp/record_activity/model/record_activity_widget_model.dart';
import 'package:flutterapp/location/model/location_point.dart';
import 'package:flutterapp/core/model/activity_ranking.dart';
import 'package:flutterapp/location/service/location_observer.dart';
import 'package:flutterapp/record_activity/service/record_activity_service.dart';
import 'package:flutterapp/core/utils/datetime_utils.dart';
import 'package:flutterapp/record_activity/widget/record_activity_widget.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import '../../location/service/location_service.dart';

abstract class AbstractActivityLocationObserver implements LocationObserver {
  final profile = GlobalConfiguration().getString("profile");
  final playerActivityService = new RecordActivityService();
  final raceRestService = new RaceRestService();
  RankingType rankingType = RankingType.PLAYER_NPC;
  RecordActivityWidgetState state;
  var activityType = ActivityType.OUTDOOR_RIDE;

  AbstractActivityLocationObserver() {
    LocationService
        .INSTANCE
        .registerObserver(this);
  }

  RecordActivityWidgetModel mapToModel(ActivityRanking activityRanking);

  @mustCallSuper
  void init(State state) {
    this.state = state;
  }

  updateRankingType(RankingType rankingType) {
    this.rankingType = rankingType;
    afterUpdateRankingType();
  }

  void afterLocationChanged(LocationPoint locationPoint);

  List<RankingItem> afterRankingMap(List<RankingItem> rankingItems);

   void afterUpdateRankingType();

  List<RankingItem> mapToRankingItems(ActivityRanking activityRanking);

  Future<void> onLocationChanged(LocationPoint locationPoint) async {
    playerActivityService.addLocation(locationPoint);
    this.afterLocationChanged(locationPoint);
  }

  void updateState(RecordActivityWidgetModel model) {
    this.state.updateState(model);
  }

  void finish(RecordActivityWidgetModel model) {
    LocationService
        .INSTANCE
        .unRegisterObserver(this);
    this.state.finish(model);
  }

  List<RecordActivityWidgetRankingItem> prepareSortedRankingItems(ActivityRanking activityRanking) {
    final List<RankingItem> rankingItems = this.afterRankingMap(mapToRankingItems(activityRanking));
    rankingItems.sort((RankingItem o1, RankingItem o2) => o1.timeInSec.compareTo(o2.timeInSec));
    return rankingItems
        .map((item) =>
          new RecordActivityWidgetRankingItem(
              item.activityType,
              item.type,
              formatToLostTimeText(rankingItems[0], item),
              new NumberFormat("##0.00", "en_US").format(item.power).toString(),
              item.country,
              item.name))
        .toList();
  }

  String formatToLostTimeText(RankingItem leader, RankingItem current) {
    return leader == current ?
        DateTimeUtils.formatTime(leader.timeInSec.round()) :
        '+ ' + DateTimeUtils.formatTime(current.timeInSec.round() - leader.timeInSec.round());
  }
}

class RankingItem {
  final ActivityType activityType;
  final String name;
  final RankingItemRaceEventType type;
  final String country;
  final double power;
  final double timeInSec;

  RankingItem({
    this.activityType,
    this.name,
    this.type = RankingItemRaceEventType.NPC,
    this.country = "POL",
    this.power = 1.0,
    this.timeInSec});
}