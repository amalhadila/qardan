part of 'update_location_cubit.dart';

abstract class UpdateLocationState {}

class UpdateLocationInitial extends UpdateLocationState {}

class UpdateLocationLoading extends UpdateLocationState {}

class UpdateLocationSuccess extends UpdateLocationState {
  final String message;
  UpdateLocationSuccess(this.message);
}

class UpdateLocationFailure extends UpdateLocationState {
  final String error;
  UpdateLocationFailure(this.error);
}
