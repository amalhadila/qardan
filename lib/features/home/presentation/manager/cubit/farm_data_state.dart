import 'package:qardan/features/home/data/model/farm_model.dart';

abstract class FarmDataState {}

class FarmDataInitial extends FarmDataState {}

class FarmDataLoading extends FarmDataState {}

class FarmDataLoaded extends FarmDataState {
  final List<SectorData> sectors;

  FarmDataLoaded(this.sectors);
}

class FarmDataError extends FarmDataState {
  final String message;

  FarmDataError(this.message);
}
