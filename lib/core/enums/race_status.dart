class RaceStatus {
  static const RaceStatus NOT_STARTED = RaceStatus._('NOT_STARTED');
  static const RaceStatus IN_PROGRESS = RaceStatus._('IN_PROGRESS');
  static const RaceStatus FINISHED = RaceStatus._('FINISHED');
  static const RaceStatus CANCELLED = RaceStatus._('CANCELLED');

  final String _name;
  const RaceStatus._(this._name);

  String toString() {
    return _name;
  }

  static RaceStatus findByName(String name) {
    switch (name) {
      case "NOT_STARTED":
        return RaceStatus.NOT_STARTED;
      case "IN_PROGRESS":
        return RaceStatus.IN_PROGRESS;
      case "FINISHED":
        return RaceStatus.FINISHED;
      default:
        return RaceStatus.CANCELLED;
    }
  }
}