import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/bottom_bar_view.dart';

class LocationPermissionScreen extends StatefulWidget {
  @override
  _LocationPermissionScreenState createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      // طلب الإذن
      status = await Permission.location.request();
      if (status.isDenied) {
        // عرض رسالة توضيحية
        _showDialog('للحصول على أفضل تجربة، يرجى منح الإذن للوصول إلى الموقع.');
      } else if (status.isPermanentlyDenied) {
        // توجيه المستخدم إلى إعدادات التطبيق
        _showDialog('تم رفض الإذن بشكل دائم. يرجى تغيير الإعدادات من إعدادات التطبيق.');
      } else {
        // إذا تم منح الإذن، احصل على الموقع الحالي
        _currentPosition = await _determinePosition();
        if (_currentPosition != null) {
          _navigateToHome(_currentPosition!.latitude, _currentPosition!.longitude);
        }
      }
    } else if (status.isGranted) {
      // الإذن ممنوح، احصل على الموقع
      _currentPosition = await _determinePosition();
      if (_currentPosition != null) {
        _navigateToHome(_currentPosition!.latitude, _currentPosition!.longitude);
      }
    }
  }

  Future<Position?> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'خدمات الموقع معطلة.';
      }

      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      _showErrorDialog(e.toString());
      return null;
    }
  }

  void _navigateToHome(double lat, double long) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomBarView(lat: lat, long: long),
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تنبيه'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('خطأ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('حسنًا'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الموقع'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomBarView(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ep_location.png',
                width: 232.w,
                height: 264.h,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20.h),
              Text(
                'شغل الموقع بتاعك',
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Text(
                'افتح الموقع علشان نقدر نشوف الأرض بتاعتك، '
                'ونتابع معاك كل حاجة تخص الزراعة.',
                textAlign: TextAlign.center,
                style: Styles.textStyle16.copyWith(color: Color(0xff8E8E8E)),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () async {
                  await _checkLocationPermission();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.primaryColor,
                  minimumSize: Size(324.w, 46.h),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    'السماح بالموقع',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}