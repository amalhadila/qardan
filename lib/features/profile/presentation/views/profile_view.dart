import 'package:flutter/material.dart';
import 'package:qardan/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, this.lat, this.long});
final double? lat;
  final double? long;

  @override
  Widget build(BuildContext context) {
    return  ProfileViewBody(lat:lat,long:long);
  }
}