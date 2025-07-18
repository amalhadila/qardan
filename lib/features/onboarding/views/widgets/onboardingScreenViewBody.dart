import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/manager/cubit/update_location_cubit.dart';
import 'package:qardan/features/home/presentation/views/widgets/location_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class onboardingScreenViewBody extends StatelessWidget {
  onboardingScreenViewBody({super.key});

  final List<PageViewModel> pages = [
    PageViewModel(
      decoration:  PageDecoration(
          pageColor: ColorApp.backgroundColor, bodyTextStyle: Styles.textStyle16),
      image: Image.asset(
        'assets/onboarding1.png',
        width: 270.w,
        height: 288.h,
        fit: BoxFit.fill,
      ),
      title: '',
      bodyWidget: Center(
        widthFactor: .7,
        child: Text(
          maxLines: 4,
          textAlign:TextAlign.center,
            'أهلا بيك يا فلاحنا الشاطر احنا هنا معاك عشان يبقي عندك حصاد لانهائي!',
            style: Styles.textStyle16),
      ),
    ),
    PageViewModel(
      decoration:  PageDecoration(
          pageColor: ColorApp.backgroundColor, bodyTextStyle: Styles.textStyle16),
      image: Image.asset(
        'assets/onboarding2.png',
        width: 270.w,
        height: 288.h,
        fit: BoxFit.fill,
      ),
      title: '',
      bodyWidget: Center(
         widthFactor: .7,
        child: Text(
           maxLines: 4,
          textAlign:TextAlign.center,
            'خليك متابع حالة الطقس كل يوم وتوقعات الجو علشان تزرع صح.',
            style: Styles.textStyle16),
      ),
    ),
    PageViewModel(
      decoration:  PageDecoration(
          pageColor: ColorApp.backgroundColor, bodyTextStyle: Styles.textStyle16),
      image: Image.asset(
        'assets/onboarding3.png',
        width: 270.w,
        height: 288.h,
        fit: BoxFit.fill,
      ),
      title: '',
      bodyWidget: Center(
         widthFactor: .7,
        child: Text(
           maxLines: 4,
          textAlign:TextAlign.center,
            'مش هيفوتك أي حاجه مهمة مع الإشعارات اللي بتفكرك بكل حاجه، من الري للجو للمواعيد المهمه.',
            style: Styles.textStyle16),
      ),
    ),

    PageViewModel(
      decoration:  PageDecoration(
          pageColor: ColorApp.backgroundColor, bodyTextStyle: Styles.textStyle16),
      image: Image.asset(
        'assets/onboarding4.png',
        width: 270.w,
        height: 288.h,
        fit: BoxFit.fill,
      ),
      title: '',
      bodyWidget: Center(
         widthFactor: .7,
        child: Text(
           maxLines: 4,
          textAlign:TextAlign.center,
            'هتقدر تصور النبات بالكاميرا والذكاء الصناعي هيشخصلك المرض ويديك العلاج المناسب.',
            style: Styles.textStyle16),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          globalBackgroundColor: ColorApp.backgroundColor,
          pages: pages,
          dotsDecorator:  DotsDecorator(
            size: Size(14.w, 3.h),
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.r)),),
            activeSize: Size(14.w, 3.h),
            activeShape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.r)),),
            color: ColorApp.secondaryColor,
            activeColor: ColorApp.primaryColor,
          ),
          showDoneButton: true,
          done: Container(
            decoration: BoxDecoration(
              color: ColorApp.primaryColor,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorApp.backgroundColor,
                size: 25,
              ),
            ),
          ),
          showBackButton:true,
          back: Container(
            decoration: BoxDecoration(
              color: ColorApp.primaryColor,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: ColorApp.backgroundColor,
                size: 25,
              ),
            ),
          ),
          showNextButton: true,
          next:  Container(
            decoration: BoxDecoration(
              color: ColorApp.primaryColor,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorApp.backgroundColor,
                size: 25,
              ),
            ),
          ),
          onDone: () => onDone(context),
          curve: Curves.linear,
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
Navigator.push(context, MaterialPageRoute(builder:(context) =>BlocProvider(
      create: (_) => UpdateLocationCubit(),
      child: LocationPermissionScreen())));
  }
}