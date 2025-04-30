import 'package:qardan/features/home/data/model/notification_model.dart';

abstract class AlertsState {}

class AlertsInitial extends AlertsState {}

class AlertsLoading extends AlertsState {}

class AlertsSuccess extends AlertsState {
  final List<AlertModel> alerts;

  AlertsSuccess(this.alerts);
    @override

      List<Object> get props => [alerts];

}

class AlertsError extends AlertsState {
  final String message;

  AlertsError(this.message);
}
