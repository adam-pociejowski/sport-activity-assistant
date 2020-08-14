import 'package:flutterapp/enums/activity_type.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';

class RecordActivityWidgetModel {
  final double currentDistanceInKm;
  final int currentPlayerPosition;
  final List<RecordActivityWidgetRankingItem> ranking;

  RecordActivityWidgetModel(
      this.currentDistanceInKm,
      this.currentPlayerPosition,
      this.ranking);
}

class RecordActivityWidgetRankingItem {
  final ActivityType activityType;
  final RankingItemRaceEventType itemType;
  final String timeText;
  final String power;
  final String country;
  final String name;

  RecordActivityWidgetRankingItem(
      this.activityType,
      this.itemType,
      this.timeText,
      this.power,
      this.country,
      this.name);
}