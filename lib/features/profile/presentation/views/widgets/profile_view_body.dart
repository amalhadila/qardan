import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/profile/presentation/views/contact_us_view.dart';
import 'package:qardan/features/profile/presentation/views/weather_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        title: Text('الملف الشخصي'),
        backgroundColor: ColorApp.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: (){},icon:Icon(Icons.edit_outlined))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 29.h),
           Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://example.com/user.jpg'),
                ),
                SizedBox(height: 10),
                Text('حسن محمد عبد الحميد احمد', style: Styles.textStyle16.copyWith(color: ColorApp.black)),
              ],
            ),
          
          SizedBox(height: 24.h),
          Expanded(
            child: ListView(
              children: [
                profileOption(Icons.person_outlined, 'ملفي الشخصي'),
                profileOption(Icons.settings_outlined, 'الإعدادات'),
                profileOption(Icons.cloud, 'الطقس',ontap:  (){ Navigator.push(context, MaterialPageRoute(builder:(context) => WeatherView()));}),
                profileOption(Icons.handshake_outlined, 'شاركنا مشكلتك',ontap:  (){ Navigator.push(context, MaterialPageRoute(builder:(context) => ContactUsView()));}
 ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileOption(IconData icon, String title, {void Function()? ontap,Color iconColor = ColorApp.primaryColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12).r,
      child: GestureDetector(
        onTap: ontap,
        child: Card(
          color: ColorApp.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Color(0xffE6E6E6))),
          child: ListTile(
            leading: Icon(icon, color: iconColor),
            title: Text(title, style: Styles.textStyle14),
            trailing: Icon(Icons.arrow_forward, color: Color(0xff7A7A7A)),
          ),
        ),
      ),
    );
  }
}
