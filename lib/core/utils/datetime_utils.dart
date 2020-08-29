import 'package:intl/intl.dart';

class DateTimeUtils {
  static getTimeDiff(DateTime after, DateTime before) {
    return after.millisecondsSinceEpoch - before.millisecondsSinceEpoch;
  }

  static toDateFormat(String datetime) {
    return toDateFormatFromDate(DateTime.parse(datetime));
  }

  static toDateFormatFromDate(DateTime datetime) {
    return new DateFormat('dd/MM/yyyy').format(datetime);
  }

  static formatTime(int timeInSec) {
    var hours = (timeInSec ~/ 3600).toString();
    timeInSec %= 3600;
    var minutes = _formatMinutes(hours, timeInSec ~/ 60);
    timeInSec %= 60;
    var seconds = _formatSeconds(timeInSec);
    return _prepareFinalTimeText(hours, minutes, seconds);
  }

  static _formatMinutes(String hours, int minutes) {
    if (hours == '0') {
      return minutes.toString();
    }
    return minutes >= 10 ? minutes.toString() : '0' + minutes.toString();
  }

  static _formatSeconds(int timeMetric) {
    if (timeMetric >= 10) {
      return timeMetric.toString();
    } else if (timeMetric > 0) {
      return '0' + timeMetric.toString();
    }
    return '00';
  }

  static _prepareFinalTimeText(String hours, String minutes, String seconds) {
    if (hours == '0') {
      if (minutes == '00') {
        return seconds + '\'\'';
      }
      return minutes + '\' ' + seconds + '\'\'';
    }
    return hours + 'h ' + minutes + '\' ' + seconds + '\'\'';
  }
}
