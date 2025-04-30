import 'package:qardan/features/home/data/model/report_mpdel.dart';

abstract class NutrientReportState {}

class NutrientReportInitial extends NutrientReportState {}

class NutrientReportLoading extends NutrientReportState {}

class NutrientReportLoaded extends NutrientReportState {
  final NutrientReportModel report;

  NutrientReportLoaded(this.report);
}

class NutrientReportError extends NutrientReportState {
  final String message;

  NutrientReportError(this.message);
}
