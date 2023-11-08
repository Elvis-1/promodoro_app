class WorkEntry {
  final String startTimestamp;
  final String stopTimestamp;

  WorkEntry({required this.startTimestamp, required this.stopTimestamp});

  factory WorkEntry.fromJson(Map<String, dynamic> json) {
    return WorkEntry(
      startTimestamp: json['startTimestamp'],
      stopTimestamp: json['stopTimestamp'],
    );
  }
}
