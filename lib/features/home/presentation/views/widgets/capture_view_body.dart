import 'dart:io';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/widgets/gallery_view_body.dart';

class CaptureViewBody extends StatefulWidget {
  const CaptureViewBody({super.key});

  @override
  State<CaptureViewBody> createState() => _CaptureViewBodyState();
}

class _CaptureViewBodyState extends State<CaptureViewBody> {
    Future<void> _showTipsDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('نصائح عشان نشخص صح',style: Styles.textStyle16.copyWith(color: ColorApp.primaryColor),)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1- اتأكد إن المساحة كويسة قبل التصوير.',style: Styles.textStyle13,),
              Text('2- حاول تقرب التفاصيل عشان الصورة تكون واضحة.',style: Styles.textStyle13),
              Text('3- جرب تغيير الزاوية لتصوير أكثر دقة.',style: Styles.textStyle13),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () async{
              Navigator.pop(context);
              await _initializeCamera();
                },
                 style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.primaryColor,
                          minimumSize: Size(94.w, 46.h),
                        ),
                child: Text('تمام',style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w600,color: ColorApp.backgroundColor),),
              ),
            ),
          ],
        );
      },
    );}
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

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller?.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _captureImage() async {
    if (!_controller!.value.isInitialized) return;
    final image = await _controller!.takePicture();
    setState(() {
      _capturedImages.add(File(image.path));
    });
  }

  Future<void> _pickFromGallery() async {
    // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   setState(() {
    //     _capturedImages.add(File(pickedFile.path));
    //   });
      _navigateToGallery();
  //  }
  }

  void _navigateToGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => GalleryViewBody(images: _capturedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body:
          CameraPreview(_controller!), 
                  
         
          
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(bottom:20).r,
        child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickFromGallery,
                        child: Icon(Icons.image, size: 40, color: ColorApp.black),
                      ),
                     
                      
                    ],
                  ),
                  SizedBox(width: 70.w),
                       GestureDetector(
                        onTap: _captureImage,
                        child: Icon(Icons.circle, size: 70, color: ColorApp.black),
                      ),
                ],
              ),
      ),
    );
  }
}