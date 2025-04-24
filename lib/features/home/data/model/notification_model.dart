class AlertModel {
  final String message;
  final String alertTime;

  AlertModel({required this.message, required this.alertTime});

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      message: json['message'],
      alertTime: json['alert_time'],
    );
  }
}
