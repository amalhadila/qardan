import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qardan/features/home/data/repo/home_repo.dart';

part 'weather_cubit_state.dart';

class WeatherCubitCubit extends Cubit<WeatherCubitState> {
  WeatherCubitCubit(this.homerepo) : super(WeatherCubitInitial());
final HomeRepo homerepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchweather(double? lat, double? long) async {
        print(lat);
      print(long);
      if (lat == null || long == null) {
      emit(WeatherCubitLocationNotSet());
      return;
    }
    if (_closed) return;
    emit(WeatherCubitLoading());
    var result = await homerepo.fetch_weather( lattitude:lat, longitude: long);
    result.fold((Failure) {
      if (!_closed) emit(WeatherCubitFailure(Failure.message));
    }, (Weather) {
      if (!_closed) emit(WeatherCubitSuccess(Weather));
    });
  }
}
