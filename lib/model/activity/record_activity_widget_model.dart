class RecordActivityWidgetModel {
  final int currentDistanceInKm;
  final int currentPlayerPosition;
  final List<RecordActivityWidgetRankingItem> ranking;

  RecordActivityWidgetModel(
      this.currentDistanceInKm,
      this.currentPlayerPosition,
      this.ranking);
}

class RecordActivityWidgetRankingItem {
  final String activityType;
  final bool isPlayerResult;
  final String timeText;
  final String name;

  RecordActivityWidgetRankingItem(
      this.activityType,
      this.isPlayerResult,
      this.timeText,
      this.name);
}