import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/constants/asset_images.dart';
import 'package:qardan/features/login/presentation/views/lang_view.dart';

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
        padding:  EdgeInsets.symmetric(horizontal:5.0).r,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
                        
              const Spacer(flex: 3,),
              Image.asset(AssetImages.splash,width:180.w,
              height:180.h,fit: BoxFit.fill,),                      
             
             
             
              const Spacer(flex: 4,),
          
            ],
          ),
        ),
      ),
    );
  }
}