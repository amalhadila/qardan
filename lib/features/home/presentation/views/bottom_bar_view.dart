import 'package:flutter/material.dart';
import 'package:qardan/features/home/presentation/views/widgets/bottom_bar_view_dart.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key, this.lat, this.long});
  final double? lat;
  final double? long;

  @override
  Widget build(BuildContext context) {
    return   BottomBarViewDart (lat: lat,long: long,);
  }
}