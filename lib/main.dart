import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/splash/presentation/views/splash_view.dart';


void main() async{
     WidgetsFlutterBinding.ensureInitialized();
          await ScreenUtil.ensureScreenSize();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          theme: ThemeData(appBarTheme: AppBarTheme(titleTextStyle:  Styles.textStyle24)),
      title: 'Flutter Demo',
       debugShowCheckedModeBanner: false,
       home: SplashView(),
       locale: Locale('ar'),
        supportedLocales: [
        Locale('ar'), // العربية
        Locale('en'), // الإنجليزية
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );});
  }
}
