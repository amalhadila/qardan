import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/bottom_bar_view.dart';

class LocationPermissionScreen extends StatefulWidget {
  @override
  _LocationPermissionScreenState createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  @override
      Position? _currentPosition;

  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _navigateToHome(); 
    }
  }

   Future<Position> _determinePosition() async {
    try {
      bool serviceEnabled;

      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied, we cannot request permissions.';
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return Future.error(e.toString());
    }
  }

  void _navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomBarView()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('الموقع'),
        centerTitle: true,
        leading:  IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomBarView()), 
    );},
                        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/ep_location.png', width: 232.w,height: 264.h,fit: BoxFit.fill,), 
              SizedBox(height: 20.h),
              Text(
                'شغل الموقع بتاعك',
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Text(
                'افتحتنا الموقع بتاعك علشان نقدر نشوف الأرض بتاعتك، '
                'ونتابع معاك كل حاجة تخص الزراعة.',
                textAlign: TextAlign.center,
                style: Styles.textStyle16.copyWith(color: Color(0xff8E8E8E)),
              ),
              SizedBox(height: 40.h),
             ElevatedButton(
                        onPressed: () async {
                          await _determinePosition().then((value) async {
                setState(() {
                  _currentPosition = value;
                  print(_currentPosition?.latitude.toString());
                  print(_currentPosition?.longitude.toString());
                }); });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BottomBarView()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.primaryColor,
                          minimumSize: Size(324.w, 46.h),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text('السماح بالموقع', style: TextStyle(color: Colors.white)),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}