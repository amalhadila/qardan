import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/home/data/model/image_analysis_model.dart';
import 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());

  final Dio _dio = Dio();

  Future<void> uploadImage(String base64Image, String sectorId) async {
    emit(UploadImageLoading());
    try {
      final response = await _dio.post(
        'https://lobster-fast-solely.ngrok-free.app/api/phone-camera/upload',
        data: {
          "sector_internal_id": sectorId,
          "image": base64Image,
          "ngrok-skip-browser-warning": "true",
        },
      );

      final data = ImageAnalysisResponse.fromJson(response.data);

      emit(UploadImageSuccess(
        message: data.message,
        solution: data.solution,
        stage: data.stage,
        diseaseName: data.diseaseName,
        imagesToday: data.imagesToday,
        remainingToday: data.remainingToday,
      ));
      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');

    } catch (e) {
      emit(UploadImageFailure(errorMessage: e.toString()));
    }
  }
}
