import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/features/login/presentation/manger/cubit/retrieve_code_cubit.dart';
import 'package:qardan/features/login/presentation/views/widgets/restore_code_view_body.dart';

class RestoreCodeView extends StatelessWidget {
  const RestoreCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RetrieveCodeCubit(),
      child: RestoreCodeViewBody(),
    );
  }
}
