import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20).r,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5, 
                itemBuilder: (context, index) {
                  return NotificationItem();
                },
              ),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'شوف كل الإشعارات القديمة',
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'تذكير',
                        style: Styles.textStyle16.copyWith(color: ColorApp.black),
                      ),
                      Spacer(),
                       Text(
                    '٣ دقائق',
                    style: Styles.textStyle12,
                  ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'يا حاج حسن، القمح محتاج سقايه بعد بكره الصبح بدري عشان يمتص الميه كويس من غير متأثر بالدير.',
                    style:Styles.textStyle14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}