
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/color_app.dart';
import '../../../../../core/theme/styles.dart';
import '../../manager/cubit/upload_image_cubit.dart';
import '../../manager/cubit/upload_image_state.dart';
import 'gallery_view_body.dart';

class CaptureViewBody extends StatefulWidget {
  final String? sectorId;

  CaptureViewBody({Key? key, this.sectorId}) : super(key: key);

  @override
  _CaptureViewBodyState createState() => _CaptureViewBodyState();
}

class _CaptureViewBodyState extends State<CaptureViewBody> {
  CameraController? _controller;
  List<File> _capturedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTipsDialog();
    });
  }

  Future<void> _showTipsDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'نصائح عشان نشخص صح',
              style: Styles.textStyle16.copyWith(color: ColorApp.primaryColor),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1- اتأكد إن المساحة كويسة قبل التصوير.', style: Styles.textStyle13),
              Text('2- حاول تقرب التفاصيل عشان الصورة تكون واضحة.', style: Styles.textStyle13),
              Text('3- جرب تغيير الزاوية لتصوير أكثر دقة.', style: Styles.textStyle13),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _initializeCamera();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.primaryColor,
                  minimumSize: Size(94.w, 46.h),
                ),
                child: Text(
                  'تمام',
                  style: Styles.textStyle18.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorApp.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller?.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _captureImage() async {
    if (!_controller!.value.isInitialized) return;
    final image = await _controller!.takePicture();
    final file = File(image.path);

    setState(() {
      _capturedImages.add(file);
    });

    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);

    context.read<UploadImageCubit>().uploadImage(base64Image, widget.sectorId ?? '1');
  }

  Future<void> _pickFromGallery() async {
    _navigateToGallery();
  }

  void _navigateToGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryViewBody(images: _capturedImages),
      ),
    );
  }

  Widget _buildCameraView() {
    return BlocConsumer<UploadImageCubit, UploadImageState>(
      listener: (context, state) {
        if (state is UploadImageFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل في رفع الصورة: ${state.errorMessage}')),
          );
        } else if (state is UploadImageSuccess) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    'نتيجة التشخيص',
                    style: Styles.textStyle16.copyWith(color: ColorApp.primaryColor),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('المرض: ${state.diseaseName ?? "غير معروف"}', style: Styles.textStyle18),
                    SizedBox(height: 8),
                    Text('المرحلة: ${state.stage ?? "غير محدد"}', style: Styles.textStyle16),
                    SizedBox(height: 8),
                    Text('الوصف: ${state.message ?? "لا يوجد وصف"}', style: Styles.textStyle13),
                    SizedBox(height: 8),
                    Text('الحل: ${state.solution ?? "لا يوجد حل"}', style: Styles.textStyle13),
                  ],
                ),
                actions: [
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'إغلاق',
                        style: Styles.textStyle16.copyWith(color: ColorApp.primaryColor),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (_controller == null || !_controller!.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            CameraPreview(_controller!),
            if (state is UploadImageLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(color: ColorApp.primaryColor),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20).r,
      child: Row(
  children: [
    Spacer(flex: 2,), // يزق الأيقونات لليمين
    GestureDetector(
      onTap: _captureImage,
      child: Icon(Icons.circle, size: 70, color: ColorApp.black),
    ),
    Spacer(), // يخلي الكاميرا في النص
    GestureDetector(
      onTap: _pickFromGallery,
      child: Icon(Icons.image, size: 40, color: ColorApp.black),
    ),
    Spacer(),
  ],
)

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _buildCameraView(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
