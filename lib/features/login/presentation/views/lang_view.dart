import 'package:flutter/material.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/features/login/presentation/views/widgets/lang_view_body.dart';

class LangView extends StatelessWidget {
  const LangView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      body: LangViewBody(),
    );
  }
}