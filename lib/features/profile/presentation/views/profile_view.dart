import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/logout_cubit_cubit.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/update_profile_cubit.dart';
import 'package:qardan/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, this.lat, this.long});
  final double? lat;
  final double? long;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateProfileCubit(),
        ),
        BlocProvider(
        create: (_) => LogoutCubit(), 
               ),
      ],
      child: ProfileViewBody(lat: lat, long: long),
    );
  }
}
