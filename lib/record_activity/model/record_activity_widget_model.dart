import 'package:flutterapp/core/enums/activity_type.dart';
import 'package:flutterapp/core/enums/race_status.dart';
import 'package:flutterapp/core/enums/ranking_item_race_event_type.dart';

class RecordActivityWidgetModel {
  final double currentDistance;
  final double overallDistance;
  final int currentPlayerPosition;
  final RaceStatus status;
  final List<RecordActivityWidgetRankingItem> ranking;

  RecordActivityWidgetModel(
      this.currentDistance,
      this.overallDistance,
      this.currentPlayerPosition,
      this.status,
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