import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/shared_widgets.dart/loading_widgets.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/manager/cubit/weather_cubit_cubit.dart';
import 'package:qardan/features/home/presentation/views/widgets/divider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubitCubit, WeatherCubitState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('أهلاً بك',
                        style: Styles.textStyle14
                            .copyWith(color: Color(0xffA6A6A6))),
                    CircleAvatar(
                        radius: 24.r,
                        backgroundImage: AssetImage('assets/profile.jpg')),
                  ],
                ),
              ),
              Center(child: customDivider()),
              SizedBox(height: 15.h),
              Text(
                'معلوماتك',
                style: Styles.textStyle13,
              ),
              Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      WeatherIcons.day_cloudy,
                      color: Color(0xff5C5D0E),
                    ),
                    Text(
                      'الطقس',
                      style:
                          Styles.textStyle14.copyWith(color: Color(0xff5C5D0E)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              if (state is WeatherCubitSuccess) ...[
              Card(
                color: ColorApp.backgroundColor,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffE8E8E8)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: 
                
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.location_on, color: ColorApp.black),
                      Text(state.Weather["city"]),
                    ],
                  ),
                  subtitle: Text('${state.Weather["date"]}\n${state.Weather["temperature"]}C'),
                  trailing: Image.asset(
                    'assets/image5.png',
                    width: 64.w,
                    height: 45.h,
                  ),
                ),
              ),],
              if (state is WeatherCubitLoading) ...[
                LoadingWidget()
              ],
              if (state is WeatherCubitFailure) ...[
               Text( state.errMessage.toString())
              ],
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.grass, color: Color(0xff40AC44)),
                    Text('محاصيلك',
                        style: Styles.textStyle14
                            .copyWith(color: Color(0xff0E4E11))),
                  ],
                ),
              ),
              SizedBox(height: 17.h),
              Container(
                height: 93.h,
                padding: EdgeInsets.only(right: 8.w),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext, int) {
                    return Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Container(
                          height: 93.h,
                          width: 156.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.asset(
                              'assets/WhatsApp Image 2024-12-27 at 17.47.28_36c47a80 1.png',
                              fit: BoxFit.fill)),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.align_vertical_bottom,
                      color: Color(0xff2724E4),
                    ),
                    Text('مؤشرات',
                        style: Styles.textStyle14
                            .copyWith(color: Color(0xff030E56))),
                  ],
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _indicator(Color(0xff93D47E), 'البوتاسيوم'),
                        _indicator(Color(0xff4E99A1), 'الفوسفـات'),
                      ],
                    ),
                    SizedBox(
                      width: 110.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _indicator(Color(0xff0F5412), 'النيتروجين'),
                        _indicator(Color(0xff4E59A1), 'الرطوبة'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                  height: 269.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 100,
                        interval: 10,
                      ),
                      legend: Legend(
                        isVisible: true,
                        padding: 2,
                        position: LegendPosition.top,
                        offset: Offset(20, -150),
                        orientation: LegendItemOrientation.vertical,
                        alignment: ChartAlignment.far,
                        legendItemBuilder:
                            (legendText, series, point, seriesIndex) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffDADADA),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Color(0xff940E0E),
                                        size: 16,
                                      ),
                                      Text(
                                        'الكبرى',
                                        style: TextStyle(
                                            color: ColorApp.black,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        color: Color(0xffC36363),
                                        size: 16,
                                      ),
                                      Text(
                                        'الصغرى',
                                        style: TextStyle(
                                            color: ColorApp.black,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      series: <CartesianSeries<dynamic, String>>[
                        ColumnSeries<dynamic, String>(
                            dataSource: [
                              ChartData('K', 40, Color(0xffC36363)),
                              ChartData('N', 70, Color(0xffC36363)),
                              ChartData('P', 30, Color(0xffC36363)),
                              ChartData('W', 60, Color(0xffC36363)),
                            ],
                            xValueMapper: (data, _) => data.x,
                            yValueMapper: (data, _) => data.y,
                            pointColorMapper: (data, _) => data.color,
                            name: 'الصغرى',
                            isVisibleInLegend: false),
                        ColumnSeries<dynamic, String>(
                            dataSource: [
                              ChartData('K', 80, Color(0xff93D47E)),
                              ChartData('N', 40, Color(0xff0F5412)),
                              ChartData('P', 10, Color(0xff4E99A1)),
                              ChartData('W', 30, Color(0xff4E59A1)),
                            ],
                            xValueMapper: (data, _) => data.x,
                            yValueMapper: (data, _) => data.y,
                            pointColorMapper: (data, _) => data.color,
                            isVisibleInLegend: false),
                        ColumnSeries<dynamic, String>(
                          dataSource: [
                            ChartData('K', 60, Color(0xff940E0E)),
                            ChartData('N', 90, Color(0xff940E0E)),
                            ChartData('P', 20, Color(0xff940E0E)),
                            ChartData('W', 80, Color(0xff940E0E)),
                          ],
                          xValueMapper: (data, _) => data.x,
                          yValueMapper: (data, _) => data.y,
                          pointColorMapper: (data, _) => data.color,
                          name: 'الكبرى',
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

Widget _indicator(Color color, String text, {bool isCritical = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    child: Row(
      children: [
        Container(width: 12, height: 12, color: color),
        SizedBox(width: 5),
        Text(text,
            style: TextStyle(color: isCritical ? Colors.red : Colors.black)),
      ],
    ),
  );
}
