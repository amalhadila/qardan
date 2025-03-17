import 'package:dartz/dartz.dart';
import 'package:qardan/core/utils/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, Map<String, dynamic>>> fetch_weather({ double? lattitude,double? longitude});
}