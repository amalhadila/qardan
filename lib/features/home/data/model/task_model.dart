class PreventiveTask {
  final String sectorId;
  final int sectorNumber;
  final double daysSincePlanting;
  final String stage;
  final int day;
  final String message;
  final String repetition;
  final bool isCurrent;

  PreventiveTask({
    required this.sectorId,
    required this.sectorNumber,
    required this.daysSincePlanting,
    required this.stage,
    required this.day,
    required this.message,
    required this.repetition,
    required this.isCurrent,
  });

  factory PreventiveTask.fromJson(Map<String, dynamic> json) {
    return PreventiveTask(
      sectorId: json['sector_id'],
      sectorNumber: json['sector_number'],
      daysSincePlanting: (json['days_since_planting'] as num).toDouble(),
      stage: json['stage'],
      day: json['day'],
      message: json['message'],
      repetition: json['repetition'],
      isCurrent: json['is_current'],
    );
  }
}

