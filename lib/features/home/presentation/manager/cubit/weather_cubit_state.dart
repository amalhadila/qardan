part of 'weather_cubit_cubit.dart';

@immutable
sealed class WeatherCubitState {}

final class WeatherCubitInitial extends WeatherCubitState {}
class WeatherCubitLoading extends WeatherCubitState {}
class WeatherCubitLocationNotSet extends WeatherCubitState {}

class WeatherCubitFailure extends WeatherCubitState {
  final String errMessage;

   WeatherCubitFailure(this.errMessage);
}

class WeatherCubitSuccess extends WeatherCubitState {
   Map<String, dynamic> Weather;

   WeatherCubitSuccess(this.Weather);
}