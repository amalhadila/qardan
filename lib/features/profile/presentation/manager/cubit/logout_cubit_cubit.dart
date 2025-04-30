import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/logout_cubit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  final Dio dio = Dio();

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        emit(LogoutFailure('التوكن غير موجود'));
        return;
      }

      final response = await dio.post(
        'https://lobster-fast-solely.ngrok-free.app/api/farmers/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
             "ngrok-skip-browser-warning": "true",
          },
        ),
      );

      if (response.statusCode == 200) {
        // حذف التوكن من التخزين
        await prefs.remove('token');
        emit(LogoutSuccess());
      } else {
        emit(LogoutFailure('فشل تسجيل الخروج: ${response.data.toString()}'));
      }
    } catch (e) {
      emit(LogoutFailure('خطأ: ${e.toString()}'));
    }
  }
}
