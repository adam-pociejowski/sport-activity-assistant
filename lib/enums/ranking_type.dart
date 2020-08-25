class RankingType {
  static const RankingType ONLY_NPC = RankingType._('ONLY_NPC');
  static const RankingType PLAYER_NPC = RankingType._('PLAYER_NPC');
  static const RankingType PLAYER_NPC_GENERAL = RankingType._('PLAYER_NPC_GENERAL');
  static const RankingType PLAYER_NPC_WITH_HISTORY = RankingType._('PLAYER_NPC_WITH_HISTORY');

  final String _name;
  const RankingType._(this._name);

  String toString() {
    return _name;
  }

  static RankingType findByName(String name) {
    switch (name) {
      case "ONLY_NPC":
        return RankingType.ONLY_NPC;
      case "PLAYER_NPC":
        return RankingType.PLAYER_NPC;
      case "PLAYER_NPC_GENERAL":
        return RankingType.PLAYER_NPC_GENERAL;
      default:
        return RankingType.PLAYER_NPC_WITH_HISTORY;
    }
  }
}