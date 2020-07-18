class TimeSince {
  static String label(DateTime time) {
    final DateTime now = DateTime.now();

// if it's in the future, return now
    if (time.isAfter(now)) {
      return '今';
    }
    return '${time.year}';
  }
}
