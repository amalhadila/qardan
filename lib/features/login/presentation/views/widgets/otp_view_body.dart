import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/login/presentation/views/welcome_view.dart';
import 'package:qardan/features/login/presentation/manger/cubit/login_cubit.dart';

class OtpViewBody extends StatefulWidget {
  const OtpViewBody({super.key});

  @override
  State<OtpViewBody> createState() => _OtpViewBodyState();
}

class _OtpViewBodyState extends State<OtpViewBody> {
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  int secondsRemaining = 30;
  Timer? _timer;
  bool enableResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
        timer.cancel();
      }
    });
  }

  String getOtp() {
print(controllers.map((e) => e.text.trim()).join().split('').reversed.join());
return controllers.map((e) => e.text.trim()).join().split('').reversed.join();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        backgroundColor: ColorApp.primaryColor,
        body: Form(
          key: globalKey,
          child: Column(
            children: [
              const Spacer(flex: 3),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocConsumer<LoginCubit, LoginState>( 
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const WelcomeView()),
                          );
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
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
                                return SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: TextFormField(
                                    validator: (value) =>
                                        value!.isEmpty ? 'مطلوب' : null,
                                    controller: controllers[index],
                                    keyboardType: TextInputType.text, // تحديث هنا
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty && index < 3) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 37.h),
                            state is LoginLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      if (globalKey.currentState!.validate()) {
                                        LoginCubit.get(context).loginFarmer(getOtp());
                                      }
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
                            enableResend
                                ? TextButton(
                                    onPressed: () {
                                      startTimer(); // هنا تحط فنكشن إعادة الإرسال
                                    },
                                    child: Text(
                                      'إعادة إرسال رمز التأكيد',
                                      style: Styles.textStyle14_inter.copyWith(
                                        color: ColorApp.primaryColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'إعادة إرسال رمز التأكيد بعد $secondsRemaining ثانية',
                                    style: Styles.textStyle14_inter,
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
