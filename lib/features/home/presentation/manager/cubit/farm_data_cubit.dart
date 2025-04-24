import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'farm_data_state.dart';

class FarmDataCubit extends Cubit<FarmDataState> {
  FarmDataCubit() : super(FarmDataInitial());

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://lobster-fast-solely.ngrok-free.app/api/',
      headers: {
        "ngrok-skip-browser-warning": "true",
      },
    ),
  );

  Future<void> fetchFarmData() async {
    emit(FarmDataLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      print('Token: $token');

      if (token == null) {
        emit(FarmDataError("No token found"));
        return;
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get('sectors/farm-data');

      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data != null && response.data.isNotEmpty) {
          emit(FarmDataLoaded(response.data));
        } else {
          emit(FarmDataError("No data available in the response."));
        }
      } else {
        emit(FarmDataError("Failed to load farm data: ${response.statusMessage}"));
      }
    } catch (e) {
      print('Error: $e');
      emit(FarmDataError("An error occurred: $e"));
    }
  }
}
