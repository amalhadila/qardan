import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/profile/presentation/views/contact_us_view.dart';
import 'package:qardan/features/profile/presentation/views/edit_profile_view.dart';
import 'package:qardan/features/profile/presentation/views/setting_view.dart';
import 'package:qardan/features/profile/presentation/views/weather_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key,  this.lat,  this.long});

  final double? lat;
  final double ?long;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileView()));
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 29.h),
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://example.com/user.jpg'),
          ),
          const SizedBox(height: 10),
          Text(
            'حسن محمد عبد الحميد احمد',
            style: Styles.textStyle16.copyWith(color: ColorApp.black),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: ListView(
              children: [
                profileOption(
                  Icons.person_outlined,
                  'ملفي الشخصي',
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfileView()),
                  ),
                ),
                profileOption(
                  Icons.settings_outlined,
                  'الإعدادات',
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingView()),
                  ),
                ),
                profileOption(
                  Icons.cloud,
                  'الطقس',
                  ontap: () => _navigateToWeather(context),
                ),
                profileOption(
                  Icons.handshake_outlined,
                  'شاركنا مشكلتك',
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactUsView()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileOption(IconData icon, String title, {void Function()? ontap, Color iconColor = ColorApp.primaryColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12).r,
      child: GestureDetector(
        onTap: ontap,
        child: Card(
          color: ColorApp.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xffE6E6E6)),
          ),
          child: ListTile(
            leading: Icon(icon, color: iconColor),
            title: Text(title, style: Styles.textStyle14),
            trailing: const Icon(Icons.arrow_forward, color: Color(0xff7A7A7A)),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToWeather(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherView(lat: position.latitude, long: position.longitude),
        ),
      );
    }
  }
}
