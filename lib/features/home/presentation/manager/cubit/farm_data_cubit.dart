import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/home/data/model/farm_model.dart';
import 'package:qardan/features/home/presentation/manager/cubit/farm_data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      if (token == null) {
        emit(FarmDataError('Token not found'));
        return;
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get('sectors/farm-data');
      final data = (response.data as List)
          .map((e) => SectorData.fromJson(e))
          .toList();
      emit(FarmDataLoaded(data));
    } catch (e) {
      emit(FarmDataError(e.toString()));
    }
  }
}
