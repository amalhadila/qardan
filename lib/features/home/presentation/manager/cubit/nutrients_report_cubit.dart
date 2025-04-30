import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/home/data/model/report_mpdel.dart';
import 'package:qardan/features/home/presentation/manager/cubit/nutrients_report_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutrientReportCubit extends Cubit<NutrientReportState> {
  NutrientReportCubit() : super(NutrientReportInitial());

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://lobster-fast-solely.ngrok-free.app/api/',
      headers: {
        "ngrok-skip-browser-warning": "true",
      },
    ),
  );

  Future<void> fetchNutrientReport(String sectorId) async {
  emit(NutrientReportLoading());
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      emit(NutrientReportError("Token not found"));
      return;
    }

    _dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await _dio.get('sectors/$sectorId/nutrients-report');

    // طباعة استجابة API
    print('Response data: ${response.data}');

    final report = NutrientReportModel.fromJson(response.data);
    emit(NutrientReportLoaded(report));
  } catch (e) {
    // طباعة الخطأ
    print('Error fetching nutrient report: $e');
    emit(NutrientReportError(e.toString()));
  }
}
}
