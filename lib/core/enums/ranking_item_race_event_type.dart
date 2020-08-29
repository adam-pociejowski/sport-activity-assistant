class RankingItemRaceEventType {
  static const RankingItemRaceEventType NPC = RankingItemRaceEventType._('NPC');
  static const RankingItemRaceEventType USER_ACTIVITY = RankingItemRaceEventType._('USER_ACTIVITY');
  static const RankingItemRaceEventType USER_OLD_ACTIVITY = RankingItemRaceEventType._('USER_OLD_ACTIVITY');
  static const RankingItemRaceEventType OTHER_USER_ACTIVITY = RankingItemRaceEventType._('OTHER_USER_ACTIVITY');
  static const RankingItemRaceEventType OTHER_USER_OLD_ACTIVITY = RankingItemRaceEventType._('OTHER_USER_OLD_ACTIVITY');

  final String _name;
  const RankingItemRaceEventType._(this._name);

  String toString() {
    return _name;
  }

  static RankingItemRaceEventType findByName(String name) {
    switch (name) {
      case "NPC":
        return RankingItemRaceEventType.NPC;
      case "USER_ACTIVITY":
        return RankingItemRaceEventType.USER_ACTIVITY;
      case "USER_OLD_ACTIVITY":
        return RankingItemRaceEventType.USER_OLD_ACTIVITY;
      case "OTHER_USER_ACTIVITY":
        return RankingItemRaceEventType.OTHER_USER_ACTIVITY;
      default:
        return RankingItemRaceEventType.OTHER_USER_OLD_ACTIVITY;
    }
  }
}