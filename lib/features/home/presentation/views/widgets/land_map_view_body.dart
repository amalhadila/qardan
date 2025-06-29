import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/widgets/divider.dart';
import 'package:qardan/features/home/presentation/views/widgets/capture_view_body.dart'; 
class LandMapViewBody extends StatefulWidget {
  const LandMapViewBody({super.key});

  @override
  State<LandMapViewBody> createState() => _LandMapViewBodyState();
}

class _LandMapViewBodyState extends State<LandMapViewBody> {
  void _navigateToCamera(String? sectorId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaptureViewBody(sectorId: sectorId), // ابعت القيمة
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خريطة الأرض'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: customDivider()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        landButton('٣', Color(0xff4CAF50), () => ()),
                        Container(),
                        landButton('٤', Color(0xff4CAF50), () => ()),
                        landButton('١', Color(0xff4CAF50), () => ()),
                        landButton('٥', Color(0xff4CAF50), () => ()),
                        landButton('٢', Color(0xff4CAF50), () => ()),
                        landButton('٦', Color(0xff005B04), () => ()),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('نقطة البداية', style: Styles.textStyle14),
                        SizedBox(height: 5),
                        Icon(Icons.radio_button_unchecked, size: 30, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 64.sp, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
    );
  }
}
