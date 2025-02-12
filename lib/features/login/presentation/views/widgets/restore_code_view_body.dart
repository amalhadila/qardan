import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/login/presentation/views/enter_code_view.dart';
import 'package:qardan/features/login/presentation/views/otp_view.dart';

class RestoreCodeViewBody extends StatelessWidget {
   RestoreCodeViewBody({super.key});
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
        title: Center(
              child: Text(
                "استرجاع الكود",
                style:Styles.textStyle24_inter.copyWith(color:ColorApp.black)
              ),
            ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color:ColorApp.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:Form(
  key: globalKey,
  child:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              _buildInputField("الإسم", "الإسم", Icons.person_outlined),
             SizedBox(height: 18.h),
              _buildInputField("الرقم القومي", "ادخل الرقم القومي", Icons.verified_user_outlined),
             SizedBox(height: 18.h),
              _buildInputField("رقم الهاتف", "ادخل رقم الهاتف", Icons.phone_outlined),
              SizedBox(height: 49.h),
           ElevatedButton(
                  onPressed: () {
                      if (globalKey.currentState!.validate()) {
                   Navigator.push(context, MaterialPageRoute(builder:(context) => OtpView()));}
        
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.primaryColor,
                    minimumSize: Size(324.w, 46.h),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      'تأكيد',
                      style: Styles.textStyle24_inter
                    ),
                   
                  ),
                ),
             
               SizedBox(height: 200.h,)
            ],
          ),
        ),
      ),)
    );
  }

  Widget _buildInputField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.textStyle14,
        ),
        SizedBox(height: 8),
      TextFormField(
                   validator: (value){
        if (value!.isEmpty){
          return 'field is required';
        } 
        return null;
      },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Styles.textStyle14.copyWith(color:ColorApp.hintColor ),
            prefixIcon: Icon(icon,color:Color(0xffADB7AD) ,),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffADB7AD))
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffADB7AD))
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
