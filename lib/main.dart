import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/splash/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      startLocale: Locale('ar'),
      child: MyApp(isDarkMode: isDarkMode),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  MyApp({required this.isDarkMode});

  static void restartApp(BuildContext context, bool newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newTheme);

    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setTheme(newTheme);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  void setTheme(bool newTheme) {
    setState(() {
      isDarkMode = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: isDarkMode
              ? ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: ColorApp.black,
                  appBarTheme: AppBarTheme(
                    titleTextStyle: Styles.textStyle24.copyWith(color: ColorApp.backgroundColor),
                    color: ColorApp.black,
                  ),
                )
              : ThemeData.light().copyWith(
                  scaffoldBackgroundColor: ColorApp.backgroundColor,
                  appBarTheme: AppBarTheme(
                    titleTextStyle: Styles.textStyle24,
                    color: ColorApp.backgroundColor,
                  ),
                ),
          home: SplashView(),
          supportedLocales: [Locale('en'), Locale('ar')],
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
        );
      },
    );
  }
}
