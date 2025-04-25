import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/shared_widgets.dart/loading_widgets.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/manager/cubit/weather_cubit_cubit.dart';

class WeatherViewBody extends StatelessWidget {
    const WeatherViewBody({super.key, this.lat, this.long});
final double? lat;
  final double? long;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('الطقس'),
          elevation: 0,
        actions: [IconButton(onPressed: (){},icon:Icon(Icons.edit_outlined))],
      ),
      body:BlocBuilder<WeatherCubitCubit, WeatherCubitState>(
      builder: (context, state) {
        if (state is WeatherCubitSuccess){
            List<Map<String, String>> forecast = [
    {"day": "${state.Weather["tomorrow_day"]}", "temp": "${state.Weather["tomorrow_temp"]}℃"},
    {"day": "${state.Weather["day_after_tomorrow_day"]}", "temp": "${state.Weather["day_after_tomorrow_temp"]}℃"},
    {"day": "${state.Weather["fourth_day_day"]}", "temp": "${state.Weather["fourth_day_temp"]}℃"},
  ];
        return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Color(0xffE3FAFF),
              child: Column(
                children: [
                  Text(
                    '${state.Weather["city"]}\n ${state.Weather["day"]}\n ${state.Weather["date"]}',
                    style: Styles.textStyle20,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Icon(Icons.wb_sunny, size: 50, color: Colors.amber),
                  SizedBox(height: 8),
                  Text('${state.Weather["temperature"]}°C', style: Styles.textStyle20,),
                  //Text('22°C / 11°C', style:Styles.textStyle15),
                  Text('${state.Weather["description"]}', style: Styles.textStyle15),
                  SizedBox(height: 8),
                  //Text(' ☁️ 0%', style: Styles.textStyle15),
                  //SizedBox(height: 8),
                  //Text('النهاردة يوم مش كويس لرش المبيدات الحشرية.', style: Styles.textStyle15.copyWith(color: Color(0xff8B978B))),
                  //SizedBox(height: 8),
                  //Text('غروب الشمس 5:12 م', style: Styles.textStyle15),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('الأيام الثلاثه القادمة', style: Styles.textStyle15),
              ),
            ),
           Container(
            color: Color(0xffF5FAFF),
            height: 96.h, 
            child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          return Center(child: _buildWeatherDay(forecast[index]["day"]!, forecast[index]["temp"]!));
        },
            ),
          ),
        
          ],
        ),
      );}
       if (state is WeatherCubitLoading) {
              return  LoadingWidget();
              }
              if (state is WeatherCubitFailure) {
              return Text( state.errMessage.toString());
              }
              return Container();})
    );
  }

 Widget _buildWeatherDay(String day, String temp) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(day, style: Styles.textStyle15.copyWith(color:Color(0xff9DB2CE))),
        Icon(Icons.wb_sunny, color: Color(0xffFFCD29)),
        Text(temp, style: Styles.textStyle15),
      ],
    ),
  );
}}