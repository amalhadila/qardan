import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/features/home/presentation/manager/cubit/update_location_cubit.dart';
import 'package:qardan/features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:qardan/features/login/presentation/views/widgets/enter_code_view_body.dart';

class EnterCodeView extends StatelessWidget {
  const EnterCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
    BlocProvider(create: (_) => UpdateLocationCubit()),
       
      ],
      child: Scaffold(body: EnterCodeViewBody()),
    );
  }
}
