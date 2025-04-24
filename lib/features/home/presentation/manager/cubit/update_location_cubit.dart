import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_location_state.dart';

class UpdateLocationCubit extends Cubit<UpdateLocationState> {
  UpdateLocationCubit() : super(UpdateLocationInitial());

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
  }) async {
    final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token');
    emit(UpdateLocationLoading());
    try {
      final response = await Dio().post(
        'https://lobster-fast-solely.ngrok-free.app/api/farmers/update-location',
        data: {
          "latitude": latitude,
          "longitude": longitude,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "ngrok-skip-browser-warning": "true",
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
        emit(UpdateLocationSuccess(response.data['message']));
      } else {
        emit(UpdateLocationFailure("فشل التحديث"));
      }
    } catch (e) {
      print(e); 
      emit(UpdateLocationFailure("خطأ في الاتصال: ${e.toString()}"));
    }
  }
}
