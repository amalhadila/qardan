import 'package:flutter/material.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/features/login/presentation/views/widgets/enter_code_view_body.dart';

class EnterCodeView extends StatelessWidget {
  const EnterCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      body:  EnterCodeViewBody());
  }
}