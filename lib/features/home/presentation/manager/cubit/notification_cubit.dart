import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/home/data/model/notification_model.dart';
import 'package:qardan/features/home/presentation/manager/cubit/notification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertsCubit extends Cubit<AlertsState> {
  AlertsCubit() : super(AlertsInitial());

  final Dio _dio = Dio();

  Future<void> getAlerts() async {
    emit(AlertsLoading());
 final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token');
    try {
      final response = await _dio.get(
        'https://lobster-fast-solely.ngrok-free.app/api/alerts/notifications',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "ngrok-skip-browser-warning": "true",
          },
        ),
      );

      List<AlertModel> alerts = (response.data as List)
          .map((e) => AlertModel.fromJson(e))
          .toList();

      emit(AlertsSuccess(alerts));
    } catch (e) {
      emit(AlertsError(e.toString()));
    }
  }
}
