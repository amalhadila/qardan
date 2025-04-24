import 'package:flutter_bloc/flutter_bloc.dart';
import 'retrieve_code_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RetrieveCodeCubit extends Cubit<RetrieveCodeState> {
  RetrieveCodeCubit() : super(RetrieveCodeInitial());

  Future<void> retrieveCode({
    required String name,
    required String phone,
    required String nationalId,
  }) async {
    emit(RetrieveCodeLoading());

    final url = Uri.parse("https://lobster-fast-solely.ngrok-free.app/api/farmers/retrieve-login-code");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
        },
        body: json.encode({
          "name": name,
          "phone": phone,
          "national_id": nationalId,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        emit(RetrieveCodeSuccess(data["message"]));
      } else {
        emit(RetrieveCodeFailure(data["message"] ?? "Unknown error"));
      }
    } catch (e) {
      print(e);
      emit(RetrieveCodeFailure("خطأ في الاتصال بالسيرفر: $e"));
    }
  }
}
