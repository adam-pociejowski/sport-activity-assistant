import 'package:flutter/cupertino.dart';
import 'package:flutterapp/enums/activity_type.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:flutterapp/model/location/location_point.dart';
import 'package:flutterapp/service/location/location_observer.dart';
import 'package:flutterapp/service/player_activity_service.dart';
import 'package:flutterapp/util/datetime_utils.dart';
import 'package:flutterapp/widget/record_activity_widget.dart';
import 'package:global_configuration/global_configuration.dart';
import 'location/location_service.dart';

abstract class AbstractActivityLocationObserver implements LocationObserver {
  final apiUrl = GlobalConfiguration().getString("sport_activity_api_url");
  final playerActivityService = new PlayerActivityService();
  RecordActivityWidgetState state;
  var activityType = ActivityType.OUTDOOR_RIDE;

  AbstractActivityLocationObserver() {
    LocationService
        .INSTANCE
        .registerObserver(this);
  }

  RecordActivityWidgetModel mapToModel(String responseJson);

  @mustCallSuper
  void init(State state) {
    this.state = state;
  }

  void afterLocationChanged(LocationPoint locationPoint);

  List<RankingItem> afterRankingMap(List<RankingItem> rankingItems);

  List<RankingItem> mapToRankingItems(String responseJson);

  Future<void> onLocationChanged(LocationPoint locationPoint) async {
    playerActivityService.addLocation(locationPoint);
    this.afterLocationChanged(locationPoint);
  }

  void updateState(RecordActivityWidgetModel model) {
    this.state.updateState(model);
  }

  List<RecordActivityWidgetRankingItem> prepareSortedRankingItems(String responseJson) {
    final List<RankingItem> rankingItems = this.afterRankingMap(mapToRankingItems(responseJson));
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
  final double timeInSec;
  final bool isPlayerResult;

  RankingItem({
    this.activityType,
    this.name,
    this.type = RankingItemRaceEventType.NPC,
    this.country = "",
    this.timeInSec,
    this.isPlayerResult});
}