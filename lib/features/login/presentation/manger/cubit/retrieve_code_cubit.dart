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

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = json.decode(response.body);

      // التحقق من حالة النجاح
      if (response.statusCode == 200 ) {
        emit(RetrieveCodeSuccess(data["message"]));
      } else {
        String errorMessage = data["message"] ?? "حدث خطأ غير معروف";
        emit(RetrieveCodeFailure(errorMessage));
      }
    } catch (e) {
      // إذا حدث استثناء أثناء الاتصال
      String errorMessage = "خطأ في الاتصال بالسيرفر: $e";
      print(errorMessage);
      emit(RetrieveCodeFailure(errorMessage));
    }
  }
}

