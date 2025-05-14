import 'dart:math';

import 'package:cleaning_app/view/login.dart';
import 'package:cleaning_app/view/register_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                    controller: controller.firstNameController,
                    hint: "First Name",
                    inputType: TextInputType.text,
                  ),
                  RegisterTextField(
                    controller: controller.lastNameController,
                    hint: "Last Name",
                    inputType: TextInputType.text,
                  ),
                  PhoneTextField(
                    controller: controller.phoneNumberController,
                    hint: "Nomor Ponsel",
                  ),
                  RegisterTextField(
                    controller: controller.emailController,
                    hint: "Email",
                    inputType: TextInputType.emailAddress,
                  ),
                  Obx(() {
                    return RegisterTextField(
                      controller: controller.passwordController,
                      isShowPassword: controller.isPasswordVisible.value,
                      hint: "Password",
                      inputType: TextInputType.text,
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
                      isShowPassword: controller.isConfirmPasswordVisible.value,
                      hint: "Confirm Password",
                      inputType: TextInputType.text,
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
                    height: 10,
                  ),
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.verifyRegister();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(50), // Rounded corners
                          ), // Shadow color
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'Kirim OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                      ),
                    );
                  }),
                SizedBox(height: 20,),
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
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final IconButton? suffixIcon;
  final bool? isShowPassword;

  const RegisterTextField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.inputType,
      this.suffixIcon, this.isShowPassword});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isShowPassword ?? false,
        keyboardType: inputType,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon ?? null,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: 13,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}

class PhoneTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const PhoneTextField(
      {super.key,
        required this.hint,
        required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        // obscureText: obscureText,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Text(
              '+62',
              style: TextStyle(fontSize: 16),
            ),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: 13,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}

class RegisterField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final Icon prefixIcon;
  final IconButton? suffixIcon;

  const RegisterField({
    super.key,
    required this.label,
    required this.controller,
    required this.inputType,
    required this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: '$label '),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GlassmorphicTextField(
          controller: controller,
          hintText: 'Masukan $label',
          inputType: inputType,
          // prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
