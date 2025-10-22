import 'dart:math';

import 'package:cleaning_app/view/login.dart';
import 'package:cleaning_app/view/register_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/register.dart';
import '../widget/glassmorphic_textfield.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Untuk memulai, kamu perlu membuat akun.",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),
                RegisterTextField(
                  controller: controller.referalCodeController,
                  hintText: 'Masukan Kode Referal',
                  inputType: TextInputType.text,
                  isOptional: true,
                ),
                RegisterTextField(
                  controller: controller.firstNameController,
                  hintText: 'Masukan Nama Depan',
                  inputType: TextInputType.text,
                ),
                RegisterTextField(
                  controller: controller.lastNameController,
                  hintText: 'Masukan Nama Belakang',
                  inputType: TextInputType.text,
                ),
                RegisterTextField(
                  controller: controller.phoneNumberController,
                  hintText: 'Masukan Nomor Hp',
                  inputType: TextInputType.number,
                ),
                RegisterTextField(
                  controller: controller.emailController,
                  hintText: 'Masukan Email',
                  inputType: TextInputType.emailAddress,
                ),
                Obx(() {
                  return RegisterTextField(
                    controller: controller.passwordController,
                    hintText: 'Masukan Password',
                    obscureText: !controller.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                      onPressed: () => controller.isPasswordVisible.toggle(),
                    ),
                  );
                }),
                Obx(() {
                  return RegisterTextField(
                    controller: controller.confirmPasswordController,
                    hintText: 'Konfirmasi Password',
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                      onPressed: () =>
                          controller.isConfirmPasswordVisible.toggle(),
                    ),
                  );
                }),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Obx(() {
                      return Checkbox(
                        value: controller.isAgree.value,
                        onChanged: (value) {
                          controller.isAgree.value = value ?? false;
                        },
                      );
                    }),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[700]),
                          children: [
                            const TextSpan(text: "Saya menyetujui "),
                            TextSpan(
                              text: "Syarat & Ketentuan",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                   Get.toNamed("/syarat_ketentuan");
                                },
                            ),
                            const TextSpan(text: " dan "),
                            TextSpan(
                              text: "Kebijakan Privasi",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                   Get.toNamed("/privacy_policy");
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.isAgree.value
                            ? controller.verifyRegister()
                            : null;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isAgree.value
                            ? Colors.blue
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(50), // Rounded corners
                        ), // Shadow color
                      ),
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Daftar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold, // Bold text
                              ),
                            ),
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black, // Default text color
                        fontSize: 12, // Set font size as per your design
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Sudah Punya Akun? '),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },
                          text: 'Masuk ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isOptional;

  const RegisterTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.isOptional = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(hintText.replaceFirst("Masukan ", "")),
            SizedBox(width: 5,),
            (isOptional == true)
            ?Text("(opsional)",style: TextStyle(fontSize: 12,color: Colors.grey),)
            : Text("*",style: TextStyle(fontSize: 12,color: Colors.red),)
          ],
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.r),
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: inputType,
            style: TextStyle(color: Colors.black87, fontSize: 43.sp),
            //  inputFormatters: hintText == "Masukan Nomor Hp" ? [
            //   RemoveLeadingZeroFormatter(),
            //   FilteringTextInputFormatter.digitsOnly,
            // ] : null ,
            decoration: InputDecoration(
              prefixIcon:
                  prefixIcon != null
                      ? Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        child: prefixIcon,
                      )
                      : null,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black54, fontSize: 36.sp),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}