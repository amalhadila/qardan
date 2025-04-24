class ImageAnalysisResponse {
  final String message;
  final String solution;
  final String stage;
  final String diseaseName;
  final int sectorInternalId;
  final int imagesToday;
  final int remainingToday;

  ImageAnalysisResponse({
    required this.message,
    required this.solution,
    required this.stage,
    required this.diseaseName,
    required this.sectorInternalId,
    required this.imagesToday,
    required this.remainingToday,
  });

  factory ImageAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return ImageAnalysisResponse(
      message: json['message'] ?? '',
      solution: json['solution'] ?? '',
      stage: json['stage'] ?? '',
      diseaseName: json['disease_name'] ?? '',
      sectorInternalId: json['sector_internal_id'] ?? 0,
      imagesToday: json['images_today'] ?? 0,
      remainingToday: json['remaining_today'] ?? 0,
    );
  }
}
