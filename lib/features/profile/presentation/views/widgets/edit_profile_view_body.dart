import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/update_profile_cubit.dart';
import 'package:qardan/features/profile/presentation/manager/cubit/update_profile_state.dart';

class EditProfileViewBody extends StatefulWidget {
  

  const EditProfileViewBody({super.key, this.name, this.phone, this.nationalId});
  final String? name;
  final String? phone;
  final String? nationalId;
  @override
  _EditProfileViewBodyState createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {

  
  File? _image;
  final picker = ImagePicker();
  final GlobalKey<FormState> globalKey = GlobalKey();

  

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text:widget.name);
  final TextEditingController phoneController = TextEditingController(text: widget.phone);
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pop(context);
        } else if (state is UpdateProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("تعديل الملف الشخصي"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: ColorApp.black),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : AssetImage("assets/placeholder.png") as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt, color: Colors.green),
                              onPressed: _pickImage,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    buildField("الاسم", nameController, true),
                    buildField("رقم الهاتف", phoneController, true),
                    buildField("الرقم القومي", TextEditingController(text: widget.nationalId), false),
                   // buildField("الكود", TextEditingController(text: "1435"), false),
                    SizedBox(height: 55.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("إلغاء", style: Styles.textStyle16.copyWith(color: ColorApp.backgroundColor)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorApp.primaryColor, fixedSize: Size(145.w, 48.h)),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: state is UpdateProfileLoading
                                ? null
                                : () {
                                    if (globalKey.currentState!.validate()) {
                                      BlocProvider.of<UpdateProfileCubit>(context).updateProfile(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                            child: state is UpdateProfileLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("حفظ",
                                    style: Styles.textStyle16.copyWith(color: ColorApp.backgroundColor)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorApp.primaryColor, fixedSize: Size(145.w, 48.h)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 74.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildField(String label, TextEditingController controller, bool isEditable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
          enabled: isEditable,
          decoration: InputDecoration(
            prefixIcon: isEditable ? null : Icon(Icons.lock, color: Color(0xff858684)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: isEditable ? ColorApp.primaryColor : Color(0xff858684))),
            disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff858684))),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
