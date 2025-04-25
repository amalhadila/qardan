import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qardan/core/constants/asset_images.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/manager/cubit/update_location_cubit.dart';
import 'package:qardan/features/home/presentation/views/bottom_bar_view.dart';
import 'package:qardan/features/home/presentation/views/widgets/location_body.dart';
import 'package:qardan/features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:qardan/features/login/presentation/views/restore_code_view.dart';
import 'package:qardan/features/onboarding/views/widgets/onboardingScreenViewBody.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterCodeViewBody extends StatefulWidget {
  const EnterCodeViewBody({super.key});

  @override
  _EnterCodeViewBodyState createState() => _EnterCodeViewBodyState();
}

class _EnterCodeViewBodyState extends State<EnterCodeViewBody> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _checkLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
        await   context.read<UpdateLocationCubit>().updateLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBarView(
            lat: position.latitude,
            long: position.longitude,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LocationPermissionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                Image.asset(
                  AssetImages.splash,
                  width: 130.w,
                  height: 115.h,
                  fit: BoxFit.fill,
                ),
                Text('Qardan', style: Styles.textStyle20),
                SizedBox(height: 60.h),
                Text(
                  'دخل هنا الكود الخاص بيك اللي ادهنولك!',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20,
                ),
                SizedBox(height: 70.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text('الكود', style: Styles.textStyle15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    controller: _otpController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 100.h),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) async {
                    if (state is LoginSuccess) {
                      print("Token: ${state.token}");
                      print("Message: ${state.message}");
                      final prefs = await SharedPreferences.getInstance();
                        final isOnBoarding = prefs.getBool('ON_BOARDING') ?? true;

                        if (isOnBoarding) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => onboardingScreenViewBody()),
                          );
                        } else {
                          await _checkLocationPermission(context);
                        }
                    } else if (state is LoginFailure) {
                      print("Error: ${state.error}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is LoginLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                LoginCubit.get(context)
                                    .loginFarmer(_otpController.text.trim());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorApp.primaryColor,
                              minimumSize: Size(324.w, 46.h),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Text('ابدأ',
                                  style: Styles.textStyle24_inter),
                            ),
                          );
                  },
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'نسيت الكود الخاص بيك؟',
                    style:
                        Styles.textStyle16.copyWith(color: ColorApp.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestoreCodeView()),
                    );
                  },
                  child: Text(
                    'استرجاع الكود',
                    style: Styles.textStyle16
                        .copyWith(color: ColorApp.primaryColor),
                  ),
                ),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
