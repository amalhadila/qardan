import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/update_profile_cubit.dart';
import 'package:qardan/features/profile/presentation/views/widgets/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key,  this.name,  this.phone,  this.nationalId});

  final String? name;
  final String? phone;
  final String? nationalId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit(),
      child: EditProfileViewBody(name:name,phone:phone,nationalId:nationalId),
    );
  }
}
