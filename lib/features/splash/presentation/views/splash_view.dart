import 'package:flutter/material.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorApp.primaryColor,
      body: SplashViewmodel(),);
  }
}