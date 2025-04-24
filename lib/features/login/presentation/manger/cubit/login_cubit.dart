import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> loginFarmer(String loginCode) async {
    emit(LoginLoading());

    try {
      final response = await Dio().post(
        'https://lobster-fast-solely.ngrok-free.app/api/farmers/login',
        data: {
          "login_code": loginCode,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      final data = response.data;
      final token = data['token'];
      final success = data['success'];
      final message = data['message'];

      if (success == true && token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        emit(LoginSuccess(token: token, message: message));
      } else {
        emit(LoginFailure(error: message ?? 'Login failed'));
      }
    } catch (e) {
      emit(LoginFailure(error: 'Error occurred: ${e.toString()}'));
    }
  }
}
