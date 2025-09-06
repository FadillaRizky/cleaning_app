import 'package:cleaning_app/controller/register.dart';
import 'package:cleaning_app/view/menu.dart';
import 'package:cleaning_app/view/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/login.dart';
import '../widget/glassmorphic_textfield.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(53.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(child: Image.asset("assets/logo.png", width: 714.w,)),
              SizedBox(height: 180.h,),
              Text("Sign in",
                style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.bold),),
              Text("Senang bertemu denganmu lagi!",
                style: TextStyle(fontWeight: FontWeight.w500),),
              SizedBox(height: 50.h,),
              GlassmorphicTextField(
                  controller: controller.controllerphoneNumber,
                  hintText: 'Masukan Nomor Hp',
                  inputType: TextInputType.number,
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Icon(
                        Icons.phone_android,
                        color: Colors.black54,
                      ),
                    ),
                ),
              SizedBox(height: 25.h),
              Obx(() {
                return GlassmorphicTextField(
                    controller: controller.controllerPassword,
                    hintText: 'Masukan Kata Sandi Anda',
                    obscureText: !controller.isPasswordVisible.value,
                    // Changed this line
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.black54,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                      onPressed: () => controller.isPasswordVisible.toggle(),
                    ));
              }),
              SizedBox(height: 70.h),
              Obx(() =>
              controller.errorMessage.isNotEmpty
                  ? Center(
                child: Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .error,
                      fontSize: 30.sp),
                  textAlign: TextAlign.center,
                ),
              )
                  : SizedBox.shrink()),
              SizedBox(height: 10),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.loginUser(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.r), // Rounded corners
                      ), // Shadow color
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      'Masuk',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black, // Default text color
                      fontSize: 35.sp, // Set font size as per your design
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Belum Punya Akun? '),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed("/register");
                          },
                        text: 'Daftar ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}