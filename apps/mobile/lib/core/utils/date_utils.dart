import 'package:intl/intl.dart';

class AppDateUtils {
  const AppDateUtils._();

  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  static int daysBetween(DateTime start, DateTime end) {
    final startDate = startOfDay(start);
    final endDate = startOfDay(end);
    return endDate.difference(startDate).inDays;
  }

  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String dateKey(DateTime date) {
    final normalized = startOfDay(date);
    final month = normalized.month.toString().padLeft(2, '0');
    final day = normalized.day.toString().padLeft(2, '0');
    return '${normalized.year}-$month-$day';
  }

  static DateTime addMonths(DateTime date, int months) {
    final yearDelta = (date.month + months - 1) ~/ 12;
    final newYear = date.year + yearDelta;
    final newMonth = (date.month + months - 1) % 12 + 1;
    final maxDay = DateTime(newYear, newMonth + 1, 0).day;
    final day = date.day > maxDay ? maxDay : date.day;
    return DateTime(
      newYear,
      newMonth,
      day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }
}
