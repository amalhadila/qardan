import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/login/presentation/views/otp_view.dart';
import 'package:qardan/features/onboarding/views/onboarding_view.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                'أهلًا بك في قردان!',
                style: Styles.textStyle24,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 200.h),
              Image.asset(
                'assets/Confetti.png', 
                width: 128.w,
                height: 128.h,
              ),
              SizedBox(height: 70.h),
              Text(
                'تهانينا!',
                style: Styles.textStyle24,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h),
              Text(
                'حسابك جاهز',
                style: Styles.textStyle16.copyWith(color:ColorApp.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
               ElevatedButton(
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder:(context) => onboardingScreenView()));
            
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.primaryColor,
                        minimumSize: Size(324.w, 46.h),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          'يلا نبدأ',
                          style: Styles.textStyle24_inter
                        ),
                        
                       
                      ),
                      
                    ),
                     SizedBox(height: 140.h),
            ],
          ),
        ),
      ),
    );
  }
}