import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';

class WeatherViewBody extends StatelessWidget {
    const WeatherViewBody({super.key});
  @override
  Widget build(BuildContext context) {
      List<Map<String, String>> forecast = [
    {"day": "الجمعة", "temp": "16℃"},
    {"day": "السبت", "temp": "16℃"},
    {"day": "الأحد", "temp": "15℃"},
    {"day": "الاثنين", "temp": "16℃"},
  ];
    return Scaffold(
      appBar: AppBar(
        title: Text('الطقس'),
          elevation: 0,
        actions: [IconButton(onPressed: (){},icon:Icon(Icons.edit_outlined))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xffE3FAFF),
              child: Column(
                children: [
                  Text(
                    'اليوم 11 ديسمبر, المنيا',
                    style: Styles.textStyle20,
                  ),
                  SizedBox(height: 8),
                  Icon(Icons.wb_sunny, size: 50, color: Colors.amber),
                  SizedBox(height: 8),
                  Text('17°C', style: Styles.textStyle20,),
                  Text('22°C / 11°C', style:Styles.textStyle15),
                  Text('الجو النهاردة مشمس.', style: Styles.textStyle15),
                  SizedBox(height: 8),
                  Text(' ☁️ 0%', style: Styles.textStyle15),
                  SizedBox(height: 8),
                  Text('النهاردة يوم مش كويس لرش المبيدات الحشرية.', style: Styles.textStyle15.copyWith(color: Color(0xff8B978B))),
                  SizedBox(height: 8),
                  Text('غروب الشمس 5:12 م', style: Styles.textStyle15),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('الأيام الأربعة القادمة', style: Styles.textStyle15),
              ),
            ),
           Container(
            color: Color(0xffF5FAFF),
            height: 92.h, 
            child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          return _buildWeatherDay(forecast[index]["day"]!, forecast[index]["temp"]!);
        },
            ),
          ),
        
            SizedBox(height: 16),
            Text('مش متوقع سقوط أمطار الأسبوع ده', style: Styles.textStyle14),
          ],
        ),
      ),
    );
  }

 Widget _buildWeatherDay(String day, String temp) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        Text(day, style: Styles.textStyle15.copyWith(color:Color(0xff9DB2CE))),
        Icon(Icons.wb_sunny, color: Color(0xffFFCD29)),
        Text(temp, style: Styles.textStyle15),
      ],
    ),
  );
}}