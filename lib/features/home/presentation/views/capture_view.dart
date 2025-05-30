import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/features/home/presentation/views/widgets/capture_view_body.dart';

import '../manager/cubit/upload_image_cubit.dart';

class CaptureView extends StatelessWidget {
  const CaptureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UploadImageCubit(),
    child: CaptureViewBody());
  }
}