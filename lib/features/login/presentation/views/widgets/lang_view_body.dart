import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/login/presentation/views/enter_code_view.dart';
import 'package:qardan/features/onboarding/views/onboarding_view.dart';
import 'package:easy_localization/easy_localization.dart';

class LangViewBody extends StatefulWidget {
  const LangViewBody({super.key});

  @override
  State<LangViewBody> createState() => _LangViewBodyState();
}

class _LangViewBodyState extends State<LangViewBody> {
  String _selectedLanguage = "العربية"; // اللغة الافتراضية

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 75.h),
                Image.asset(
                  'assets/lucide_wheat.png',
                  width: 30.w,
                  height: 30.h,
                ),
                Text('أهلا بك!', style: Styles.textStyle24),
              ],
            ),
            SizedBox(height: 8),
            Text('اختر لغتك لاستخدام قردان', style: Styles.textStyle16),
            SizedBox(height: 80.h),

            // العربية
            RadioListTile<String>(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFDADADA)),
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text('العربية', style: Styles.textStyle24),
              subtitle: Text('الزراعة بلغتك', style: Styles.textStyle18_inter),
              value: "العربية",
              activeColor: Color(0xFF2724E4),
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                  context.setLocale(Locale('ar')); // تغيير لغة التطبيق
                });
              },
            ),

            SizedBox(height: 50.h),

            // English
            RadioListTile<String>(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFDADADA)),
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text('English', style: Styles.textStyle24),
              subtitle: Text('Farming in your language', style: Styles.textStyle18_inter),
              value: "English",
              activeColor: Color(0xFF2724E4),
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                  context.setLocale(Locale('en')); // تغيير لغة التطبيق
                });
              },
            ),

            SizedBox(height: 100.h),

            // زر القبول
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnterCodeView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primaryColor,
                minimumSize: Size(324.w, 46.h),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text("accept".tr(), style: Styles.textStyle24_inter),
              ),
            ),

            SizedBox(height: 22.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
                "terms_conditions".tr(),
                style: Styles.textStyle18,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 120.h),
          ],
        ),
      ),
    );
  }
}
