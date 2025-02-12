import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/login/presentation/views/welcome_view.dart';

class OtpViewBody extends StatelessWidget {
  OtpViewBody({super.key});

  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
        GlobalKey<FormState> globalKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.primaryColor,
      body:Form(
  key: globalKey,
  child:  Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: ColorApp.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            'تم إرسال رمز التحقق علي الواتساب',
                            style: Styles.textStyle20_inter,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                   validator: (value){
        if (value!.isEmpty){
          return 'field is required';
        } 
        return null;
      },
                            controller: controllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 37.h),
                    ElevatedButton(
                      onPressed: () {
                         if (globalKey.currentState!.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WelcomeView()));}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.primaryColor,
                        minimumSize: Size(324.w, 46.h),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text('تحقق', style: Styles.textStyle24_inter),
                      ),
                    ),
                    SizedBox(height: 23.h),
                    Text(
                      'إعادة إرسال رمز التأكيد 29:00',
                      style: Styles.textStyle14_inter,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),)
    );
  }
}
