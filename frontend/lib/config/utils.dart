String getDayString(DateTime dt) {
  String dayOfWeek = getDayOfWeekInCzech(dt.weekday);
  return dayOfWeek;
}

String getDayOfWeekInCzech(int dayIndex) {
  switch (dayIndex) {
    case DateTime.monday:
      return 'Monday';
    case DateTime.tuesday:
      return 'Tuesday';
    case DateTime.wednesday:
      return 'Wednesday';
    case DateTime.thursday:
      return 'Thursday';
    case DateTime.friday:
      return 'Friday';
    case DateTime.saturday:
      return 'Saturday';
    case DateTime.sunday:
      return 'Sunday';
    default:
      return '';
  }
}

String truncateText(String? text, int maxLength) {
  if (text != null) {
    return (text.length > maxLength) ? '${text.substring(0, maxLength)}...' : text;
  } else {
    return '';
  }
}
