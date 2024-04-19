import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimestampFormatter {
  static String databaseFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static String timesAgo(String rawDate) {
    try {
      DateTime date = DateFormat(databaseFormat).parse(rawDate);
      return timeago.format(date);
    } catch (e) {
      return '-';
    }
  }

  static String dateWithTime(String rawDate) {
    try {
      DateTime date = DateFormat(databaseFormat).parse(rawDate);
      return DateFormat('dd-MM-yyyy hh:mm a').format(date);
    } catch (e) {
      return '-';
    }
  }
}
