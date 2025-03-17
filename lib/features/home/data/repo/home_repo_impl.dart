import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:qardan/core/utils/api_service.dart';
import 'package:qardan/core/utils/failure.dart';
import 'package:qardan/features/home/data/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  final String apiKey = '0d7e40be8b3c6d8d1300d5e28819aab9';

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetch_weather({double? lattitude, double? longitude}) async {
    try {
      var response = await apiService.get(
        endpoint: 'https://api.openweathermap.org/data/2.5/forecast?lat=$lattitude&lon=$longitude&appid=$apiKey&units=metric',
      );

      final data = response;
      if (data == null || data['list'] == null || data['city'] == null) {
        return left(ServerFailure('Invalid API response'));
      }

      Map<String, Map<String, dynamic>> dailyData = {};
      final DateFormat formatter = DateFormat('EEEE', 'ar'); 

      for (var entry in data['list']) {
        if (entry['dt_txt'] == null || entry['main'] == null || entry['weather'] == null) continue;

        String date = entry['dt_txt'].split(" ")[0];
        if (!dailyData.containsKey(date)) {
          dailyData[date] = {
            "temperature": entry['main']['temp']?.toDouble() ?? 0.0,
            "description": entry['weather'][0]['description'] ?? "لا يوجد وصف",
          };
        }
      }

      List<String> dates = dailyData.keys.toList();

      final weatherData = {
        "city": data['city']['name'],
        
        "date": dates.isNotEmpty ? dates[0] : null,
        "day": dates.isNotEmpty ? formatter.format(DateTime.parse(dates[0])) : null,
        "temperature": (dates.isNotEmpty && dailyData[dates[0]] != null) ? dailyData[dates[0]]!["temperature"] : null,
        "description": (dates.isNotEmpty && dailyData[dates[0]] != null) ? dailyData[dates[0]]!["description"] : null,

        "tomorrow_date": dates.length > 1 ? dates[1] : null,
        "tomorrow_day": dates.length > 1 ? formatter.format(DateTime.parse(dates[1])) : null,
        "tomorrow_temp": (dates.length > 1 && dailyData[dates[1]] != null) ? dailyData[dates[1]]!["temperature"] : null,
        "tomorrow_description": (dates.length > 1 && dailyData[dates[1]] != null) ? dailyData[dates[1]]!["description"] : null,

        "day_after_tomorrow_date": dates.length > 2 ? dates[2] : null,
        "day_after_tomorrow_day": dates.length > 2 ? formatter.format(DateTime.parse(dates[2])) : null,
        "day_after_tomorrow_temp": (dates.length > 2 && dailyData[dates[2]] != null) ? dailyData[dates[2]]!["temperature"] : null,
        "day_after_tomorrow_description": (dates.length > 2 && dailyData[dates[2]] != null) ? dailyData[dates[2]]!["description"] : null,

        "fourth_day_date": dates.length > 3 ? dates[3] : null,
        "fourth_day_day": dates.length > 3 ? formatter.format(DateTime.parse(dates[3])) : null,
        "fourth_day_temp": (dates.length > 3 && dailyData[dates[3]] != null) ? dailyData[dates[3]]!["temperature"] : null,
        "fourth_day_description": (dates.length > 3 && dailyData[dates[3]] != null) ? dailyData[dates[3]]!["description"] : null,
      };

      return right(weatherData);

    } on DioException catch (e) {
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
