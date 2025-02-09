import 'dart:math';

import 'package:flutter/material.dart';

class customDivider extends StatelessWidget {
  const customDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: 0.38 * pi / 180,
        child: Container(
          width: 148, 
          height: 1, 
          color: Color(0xffCFCFCF),
        ),
      ),
    );
  }
}