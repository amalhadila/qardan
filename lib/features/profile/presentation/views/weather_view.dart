import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/core/utils/api_service.dart';
import 'package:qardan/features/home/data/repo/home_repo_impl.dart';
import 'package:qardan/features/home/presentation/manager/cubit/weather_cubit_cubit.dart';
import 'package:qardan/features/profile/presentation/views/widgets/weather_view_body.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key, this.lat, this.long});
  final double? lat;
  final double? long;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubitCubit(HomeRepoImpl(ApiService(Dio())))..fetchweather(lat!, long!),
      child: WeatherViewBody(lat:lat,long:long));
  }
}