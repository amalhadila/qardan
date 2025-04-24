abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageSuccess extends UploadImageState {
  final String message;
  final String solution;
  final String stage;
  final String diseaseName;
  final int imagesToday;
  final int remainingToday;

  UploadImageSuccess({
    required this.message,
    required this.solution,
    required this.stage,
    required this.diseaseName,
    required this.imagesToday,
    required this.remainingToday,
  });
}

class UploadImageFailure extends UploadImageState {
  final String errorMessage;

  UploadImageFailure({required this.errorMessage});
}
