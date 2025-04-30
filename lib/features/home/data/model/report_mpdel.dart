class NutrientReportModel {
  final String? sectorInternalId;
  final String? currentStage;
  final Map<String, dynamic>? stageMinMax;
  final Map<String, dynamic>? weekly;
  final Map<String, dynamic>? monthly;
  final Map<String, dynamic>? yearly;

  NutrientReportModel({
    this.sectorInternalId,
    this.currentStage,
    this.stageMinMax,
    this.weekly,
    this.monthly,
    this.yearly,
  });

  factory NutrientReportModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return NutrientReportModel(); // إرجاع نموذج فارغ إذا كانت البيانات null
    }

    return NutrientReportModel(
      sectorInternalId: json['sector_internal_id']?.toString(),
      currentStage: json['current_stage'],
      stageMinMax: json['stage_min_max'] != null
          ? Map<String, dynamic>.from(json['stage_min_max'])
          : null,
      weekly: json['weekly'] != null
          ? Map<String, dynamic>.from(json['weekly'])
          : null,
      monthly: json['monthly'] != null
          ? Map<String, dynamic>.from(json['monthly'])
          : null,
      yearly: json['yearly'] != null
          ? Map<String, dynamic>.from(json['yearly'])
          : null,
    );
  }
}