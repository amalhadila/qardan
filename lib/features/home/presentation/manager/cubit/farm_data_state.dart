part of 'farm_data_cubit.dart';

abstract class FarmDataState extends Equatable {
  const FarmDataState();

  @override
  List<Object> get props => [];
}

class FarmDataInitial extends FarmDataState {}

class FarmDataLoading extends FarmDataState {}

class FarmDataLoaded extends FarmDataState {
  final Map<String, dynamic> data;

  const FarmDataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class FarmDataError extends FarmDataState {
  final String message;

  const FarmDataError(this.message);

  @override
  List<Object> get props => [message];
}
