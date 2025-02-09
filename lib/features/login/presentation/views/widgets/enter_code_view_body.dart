import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/constants/asset_images.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/bottom_bar_view.dart';
import 'package:qardan/features/login/presentation/views/enter_code_view.dart';
import 'package:qardan/features/login/presentation/views/restore_code_view.dart';
import 'package:qardan/features/onboarding/views/onboarding_view.dart';

class EnterCodeViewBody extends StatelessWidget {
   EnterCodeViewBody({super.key});
 final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: ColorApp.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80.sp,),
              Image.asset(AssetImages.splash,width:130.sp,
                height:115.sp,fit: BoxFit.fill,),                
               Text(
                'Qardan',
                style: Styles.textStyle20,
              ),
               SizedBox(height: 60.sp),
               Text(
                'دخل هنا الكود الخاص بيك اللي ادهنولك!',
                textAlign: TextAlign.center,
                style: Styles.textStyle20,
              ),
               SizedBox(height: 70.sp),
              Align(
                alignment: Alignment.centerRight,
                child:  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Text(
                    'الكود',
                    style: Styles.textStyle15,
                  ),
                ),
              ),
              Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                child: TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(height: 100.sp),
               ElevatedButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder:(context) => BottomBarView()));
        
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.primaryColor,
                    minimumSize: Size(324.sp, 46.sp),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                    'ابدأ',
                   style: Styles.textStyle24_inter,
                  ),
                ),
              ),
               SizedBox(height: 30.sp),
              GestureDetector(
                onTap: () {},
                child:  Text(
                  'نسيت الكود الخاص بيك؟',
                  style:Styles.textStyle16.copyWith(color:ColorApp.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>  RestoreCodeView()));
                },
                child:  Text(
                  'استرجاع الكود',
                  style: Styles.textStyle16.copyWith(color: ColorApp.primaryColor),
                ),
              ),
               SizedBox(height:120.sp,),
            ],
          ),
        ),
      ),
    );
  }
}
