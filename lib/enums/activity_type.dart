class ActivityType {
  static const ActivityType OUTDOOR_RIDE = ActivityType._('OUTDOOR_RIDE');
  static const ActivityType VIRTUAL_RIDE = ActivityType._('VIRTUAL_RIDE');
  static const ActivityType RIDE = ActivityType._('RIDE');
  static const ActivityType RUN = ActivityType._('RUN');

  final String _name;
  const ActivityType._(this._name);

  String toString() {
    return _name;
  }

  static ActivityType findByName(String name) {
    switch (name) {
      case "OUTDOOR_RIDE":
        return ActivityType.OUTDOOR_RIDE;
      case "VIRTUAL_RIDE":
        return ActivityType.VIRTUAL_RIDE;
      case "RUN":
        return ActivityType.RUN;
      default:
        return ActivityType.RIDE;
    }
  }
}