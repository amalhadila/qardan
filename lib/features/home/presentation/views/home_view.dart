import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/core/utils/api_service.dart';
import 'package:qardan/features/home/data/repo/home_repo_impl.dart';
import 'package:qardan/features/home/presentation/manager/cubit/farm_data_cubit.dart';
import 'package:qardan/features/home/presentation/manager/cubit/weather_cubit_cubit.dart';
import 'package:qardan/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.lat, this.long});
final double? lat;
  final double? long;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubitCubit(HomeRepoImpl(ApiService(Dio())))..fetchweather(lat, long),
        ),
        BlocProvider(
          create: (context) => FarmDataCubit()..fetchFarmData(),
        ),
      ],
      child:  const HomeViewBody(),
   
      
      
    );
  }
}
