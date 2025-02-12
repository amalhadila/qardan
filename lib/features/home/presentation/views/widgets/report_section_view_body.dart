import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportSectionViewBody extends StatelessWidget {
  const ReportSectionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("التقارير"),
        centerTitle: true,
        leading:  IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                        ),      
      
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(children: [
               SizedBox(height: 40.h,),
              Icon(Icons.location_on_outlined,),
              Text('قطاع 1',style: Styles.textStyle18_inter.copyWith(color: ColorApp.black),)
             ],),
            
              
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.align_vertical_bottom,color: Color(0xff2724E4),),
                    Text('مؤشرات', style: Styles.textStyle14.copyWith(color: Color(0xff030E56))),
                  ],
                ),
              SizedBox(height: 14.h,),
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
                    SizedBox(width: 110.w,),
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
            SizedBox(height: 20.h),
           
            Container(
              height: 269.h,
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
            legendItemBuilder: (legendText, series, point, seriesIndex) {
              return  Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)   ,
                color: Color(0xffDADADA),
                     ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                       Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          
                          children: [
                            Icon(
                               Icons.arrow_upward ,
                              color: Color(0xff940E0E),
                              size: 16,
                            ),
                            Text(
                              'الكبرى',
                              style: TextStyle(color: ColorApp.black,fontSize: 12),
                            ),
                          ],
                       
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color:  Color(0xffC36363) ,
                              size: 16,
                            ),
                            Text(
                              'الصغرى',
                              style: TextStyle(color: ColorApp.black,fontSize: 12),
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
              isVisibleInLegend: false
            ),
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
              isVisibleInLegend: false
            ),
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
            )
            ),
        
             WeatherRow(icon: FontAwesomeIcons.thermometerHalf, value: "+19 C", label: "درجة حرارة التربة"),
              WeatherRow(icon: FontAwesomeIcons.tint, value: "62%", label: "الرطوبة"),
              WeatherRow(icon: FontAwesomeIcons.wind, value: "10 m/h", label: "الرياح"),
              WeatherRow(icon: FontAwesomeIcons.cloudRain, value: "0 mm", label: "سقوط الأمطار"),
          ],
        ),
            ),
      ));
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
          Text(text, style: TextStyle(color: isCritical ? Colors.red : Colors.black)),
        ],
      ),
    );
  }



class WeatherRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const WeatherRow({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Text(label, style: Styles.textStyle14),
          
          SizedBox(width: 18.w),
          Text(value, style: Styles.textStyle18),
          SizedBox(width: 45.w),
          Icon(icon),
         
        ],
      ),
    );
  }
}