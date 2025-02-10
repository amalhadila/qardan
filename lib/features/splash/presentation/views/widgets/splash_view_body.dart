import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/constants/asset_images.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/login/presentation/views/lang_view.dart';
import 'package:qardan/features/onboarding/views/onboarding_view.dart';

class SplashViewmodel extends StatefulWidget {
  const SplashViewmodel({super.key});

  @override
  State<SplashViewmodel> createState() => _SplashViewmodelState();
}

class _SplashViewmodelState extends State<SplashViewmodel> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder:(context) => LangView()));
      
    });
  }
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:5.0.sp),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
                        
              const Spacer(flex: 3,),
              Image.asset(AssetImages.splash,width:207.w,
              height:246.h,fit: BoxFit.fill,),                      
               Text('Qardan',style: Styles.textStyle20,),        
             
             
             
              const Spacer(flex: 4,),
          
            ],
          ),
        ),
      ),
    );
  }
}