import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/capture_view.dart';
import 'package:qardan/features/home/presentation/views/land_map_view.dart';
import 'package:qardan/features/home/presentation/views/report_view.dart';
import 'package:qardan/features/home/presentation/views/widgets/divider.dart';

class TasksViewBody extends StatelessWidget {
  const TasksViewBody({super.key});
  

  @override
  Widget build(BuildContext context) {
    Future<void> _showTipsDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('نصائح عشان نشخص صح',style: Styles.textStyle16.copyWith(color: ColorApp.primaryColor),)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1- اتأكد إن المساحة كويسة قبل التصوير.',style: Styles.textStyle13,),
              Text('2- حاول تقرب التفاصيل عشان الصورة تكون واضحة.',style: Styles.textStyle13),
              Text('3- جرب تغيير الزاوية لتصوير أكثر دقة.',style: Styles.textStyle13),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder:(context) => CaptureView()));
                },
                 style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.primaryColor,
                          minimumSize: Size(94.w, 46.h),
                        ),
                child: Text('تمام',style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w600,color: ColorApp.backgroundColor),),
              ),
            ),
          ],
        );
      },
    );
  }

    return Scaffold(
      appBar: AppBar(
        title: Text('جدول المهام'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:
              Padding(
                padding: const EdgeInsets.only(top: 20).r,
                child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Padding(
                        padding: EdgeInsets.only(right: 8.w,bottom: 16.h,left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder:(context) => ReportView()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff1C631E),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(10.0).r,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                   children: [
                                    Text('التقارير',style: Styles.textStyle15_inter,),
                                    Icon(Icons.align_vertical_bottom_sharp,color: Colors.white,)
                                   ],
                                     
                                  ),
                                ) ,
                              ),
                            ),
                             GestureDetector(
                                onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context) => LandMapView()));
                              },
                               child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff1C631E),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(10.0).r,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                   children: [
                                    Text('الخريطة',style: Styles.textStyle15_inter,),
                                    Icon(Icons.map,color: Colors.white,)
                                   ],
                                     
                                  ),
                                ) ,
                                                 ),
                             ),
                             GestureDetector(
                              onTap: (){
                               _showTipsDialog();
                              },
                               child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff1C631E),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(10.0).r,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                   children: [
                                    Text('الكاميرا',style: Styles.textStyle15_inter,),
                                    Icon(Icons.camera_enhance,color: Colors.white,)
                                   ],
                                     
                                  ),
                                ) ,
                                                 ),
                             ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5, 
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                                 Navigator.push(context, MaterialPageRoute(builder:(context) => CaptureView()));
                                
                              },
                              child: TaskItem());
                          },
                        ),
                      ),           
                    ],
                  ),
                ),
            
                  
    );
  }
}


class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:15).r,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffDCEEDD),
          border: Border.symmetric(horizontal: BorderSide(color: Color(0xffC8CFC8),width: 0.5))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8),
          child: Row(
            children: [
            
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.done_outline),
                        Spacer(),
                         Text(
                      '22/10/2025',
                      style: Styles.textStyle12,
                    ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      ' محتاج منك تصورلي ب الموبايل ٢٠ صوره بشكل عشوائي في القطاع رقم ٥',
                      style:Styles.textStyle14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                     SizedBox(height: 5),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text(
                          '10:30 am',
                          style: Styles.textStyle12,
                                             ),
                       ],
                     ),
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}