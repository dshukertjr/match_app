class TimeSince {
  static String label(DateTime time) {
    final DateTime now = DateTime.now();

// if it's in the future, return now
    if (time.isAfter(now)) {
      return '今';
    }
    // TODO get all the cases for time since
    return '${time.year}';
  }
}
