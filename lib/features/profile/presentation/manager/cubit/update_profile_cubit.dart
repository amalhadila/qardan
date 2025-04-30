import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/update_profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://lobster-fast-solely.ngrok-free.app/api',
      headers: {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "true",
      },
    ),
  );

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    emit(UpdateProfileLoading());
     final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
    try {
      final response = await _dio.post(
        '/farmers/update-profile',
        data: {
          'name': name,
          'phone': phone,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "ngrok-skip-browser-warning": "true",
          },
        ),
      );

      if (response.data['success'] == true) {
        emit(UpdateProfileSuccess(response.data['message']));
      } else {
        emit(UpdateProfileFailure('حدث خطأ أثناء التحديث'));
      }
    } catch (e) {
      emit(UpdateProfileFailure(e.toString()));
    }
  }
}
