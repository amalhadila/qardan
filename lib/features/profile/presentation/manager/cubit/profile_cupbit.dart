// farmer_profile_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerProfileCubit extends Cubit<FarmerProfileState> {
  FarmerProfileCubit() : super(FarmerProfileInitial());

  final Dio _dio = Dio();

  Future<void> fetchFarmerProfile() async {
    emit(FarmerProfileLoading());
 final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token');
    try {
      final response = await _dio.get('https://lobster-fast-solely.ngrok-free.app/api/farmer/profile'
      ,options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "ngrok-skip-browser-warning": "true",
          },
        ),);
      
      if (response.data['success'] == true) {
        final data = response.data['data'];
        emit(FarmerProfileLoaded(
          name: data['name'],
          phone: data['phone'],
          nationalId: data['national_id'],
        ));
      } else {
        emit(FarmerProfileError("Failed to fetch profile"));
      }
    } catch (e) {
      emit(FarmerProfileError("Error: ${e.toString()}"));
    }
  }
}
