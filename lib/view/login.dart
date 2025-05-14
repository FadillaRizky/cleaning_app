import 'package:cleaning_app/controller/register.dart';
import 'package:cleaning_app/view/menu.dart';
import 'package:cleaning_app/view/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(child: Image.asset("assets/logo.png", width: 250,)),
              SizedBox(height: 100,),
              Text("Sign in",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
              Text("Senang bertemu denganmu lagi!",
                style: TextStyle(fontWeight: FontWeight.w500),),
              SizedBox(height: 20,),
              GlassmorphicTextField(
                  controller: controller.controllerphoneNumber,
                  hintText: 'Masukan Nomor Hp',
                  inputType: TextInputType.number,
                  prefixIcon: Text(
                    '+62',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 16),
              Obx(() {
                return GlassmorphicTextField(
                    controller: controller.controllerPassword,
                    hintText: 'Masukan Kata Sandi Anda',
                    obscureText: !controller.isPasswordVisible.value,
                    // Changed this line
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5),
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
              const SizedBox(height: 16),
              const SizedBox(height: 16),
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
                      fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              )
                  : SizedBox.shrink()),
              SizedBox(height: 10),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.loginUser(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50), // Rounded corners
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
                      fontSize: 12, // Set font size as per your design
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