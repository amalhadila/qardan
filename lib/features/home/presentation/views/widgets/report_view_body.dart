import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/report_section_view.dart';

class ReportViewBody extends StatefulWidget {
  @override
  _ReportViewBodyState createState() => _ReportViewBodyState();
}

class _ReportViewBodyState extends State<ReportViewBody> {
  String selectedReport = "التقرير - الأسبوعي";

  final List<String> reports = [
    "التقرير - الأسبوعي",
    "التقرير - الشهري",
    "التقرير - السنوي",
  ];

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        title: Text("التقارير"),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading:  IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                        ),      
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(children: [
            Icon(Icons.align_vertical_bottom_sharp),
            Text('التقارير',style: Styles.textStyle24_inter.copyWith(color: ColorApp.black),)
           ],),
           SizedBox(height: 40.sp,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 52.sp,
              width: 336.sp,
              decoration: BoxDecoration(
               // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffD9D9D9),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedReport,
                  onChanged: (newValue) {
                    setState(() {
                      selectedReport = newValue!;
                    });
                  },
                  items: reports.map((String report) {
                    return DropdownMenuItem<String>(
                      value: report,
                      child: Text(report),
                    );
                  }).toList(),
                ),
              ),
            ),
           
            SizedBox(height: 25.sp),
            Text(
              "القطاعات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder:(context) => ReportSectionView()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:  Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "القطاع ${index + 1}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
