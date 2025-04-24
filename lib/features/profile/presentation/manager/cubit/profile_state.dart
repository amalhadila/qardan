import 'package:equatable/equatable.dart';

class FarmerProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FarmerProfileInitial extends FarmerProfileState {}

class FarmerProfileLoading extends FarmerProfileState {}

class FarmerProfileLoaded extends FarmerProfileState {
  final String name;
  final String phone;
  final String nationalId;

  FarmerProfileLoaded({required this.name, required this.phone, required this.nationalId});

  @override
  List<Object?> get props => [name, phone, nationalId];
}

class FarmerProfileError extends FarmerProfileState {
  final String message;

  FarmerProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
