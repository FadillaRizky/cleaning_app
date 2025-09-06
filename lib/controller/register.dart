import 'package:cleaning_app/widget/popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api.dart';
import '../model/LoginResponse.dart' as LoginModel;

class RegisterController extends GetxController {
  final RxBool isPasswordVisible = true.obs;
  final RxBool isConfirmPasswordVisible = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isAgree = false.obs;

  final RxBool isLoadingVerify = false.obs;
  final GetStorage _storage = GetStorage();
  final Rx<LoginModel.LoginResponse?> loginResponse =
      Rx<LoginModel.LoginResponse?>(null);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final otpControllers = List.generate(6, (index) => TextEditingController());
  final focusNodes = List.generate(6, (index) => FocusNode());

  void validateFields(Map<String, dynamic> fields) {
    fields.forEach((fieldName, value) {
      if (value.isEmpty) {
        throw ValidationException(
          "$fieldName wajib diisi sebelum melanjutkan.",
        );
      }
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> verifyRegister() async {
    isLoading.value = true;
    try {
      validateFields({
        "Nama Depan": firstNameController.text,
        "Nama Belakang": lastNameController.text,
        "Email": emailController.text,
        "Nomor HP": phoneNumberController.text,
        "Password": passwordController.text,
        "Konfirmasi Password": confirmPasswordController.text,
      });

      if (!isValidEmail(emailController.text.trim())) {
        SnackbarUtil.show(
          "Email tidak valid",
          "Silakan masukkan email dengan format yang benar, contoh: nama@email.com",
        );
        throw Exception("Validation Failed");
      }
      if (phoneNumberController.text.length <= 10) {
        SnackbarUtil.show(
          "Nomor HP tidak valid",
          "Nomor HP harus lebih dari 10 digit",
        );
        throw Exception("Validation Failed");
      }
      if (passwordController.text != confirmPasswordController.text) {
        SnackbarUtil.show(
          "Field Tidak Cocok",
          "Password dan konfirmasi password tidak cocok",
        );
        throw Exception("Validation Failed");
      }

      var data = {
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "phone_number": phoneNumberController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      final response = await Api.register(data);
      if (response.status == "success" && response.data != null) {
        SnackbarUtil.success("Akun berhasil dibuat, Silahkan Login..");
        Get.offAllNamed('/login');
      } else {
        SnackbarUtil.error("Registrasi gagal. Silakan coba lagi.");
      }
      // FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: '+62${phoneNumberController.text.trim()}',
      //   verificationCompleted: (phoneAuthCredential) {},
      //   verificationFailed: (error) {},
      //   codeSent: (verificationId, forceResendingToken) {

      //     Get.toNamed(
      //       '/register-verify',
      //       arguments: {
      //         'noHp': '+62${phoneNumberController.text}',
      //         'verificationId': verificationId,
      //       },
      //     );
      //   },
      //   codeAutoRetrievalTimeout: (verificationId) {
      //     print("eror");
      //   },
      // );
    } catch (e) {
      SnackbarUtil.error(e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
    ;
  }

  Future<void> register(String verificationId) async {
    isLoading.value = true;

    try {
      if (!otpControllers
          .every((controller) => controller.text.trim().isNotEmpty)) {
        throw "Otp Belum Terisi";
      }

      String otp = otpControllers.map((controller) => controller.text).join();
      final cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(cred);

      var firstName = firstNameController.text
          .trim(); // Added trim() to remove leading/trailing whitespace
      var lastName = lastNameController.text
          .trim(); // Added trim() to remove leading/trailing whitespace
      var phoneNumber = phoneNumberController.text.trim();
      var email = emailController.text.trim();
      var password = passwordController.text.trim();

      var data = {
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": "+62${phoneNumber}",
        "email": email,
        "password": password,
      };

      var loginData = {
        "phone_number": "+62${phoneNumber}",
        "password": password,
      };
      // print(data);
      final response = await Api.register(data);
      print("...${response.status}");

      if (response.status == "success" && response.data != null) {
        final response = await Api.login(loginData);
        if (response.status == "success" && response.data != null) {
          print("berhasil register dan login");
          await _saveInitialLoginData(response); // Assuming this method exists
          Get.offAllNamed('/menu');
        } else {
          EasyLoading.showSuccess("Akun berhasil dibuat, Silahkan Login..");
          Get.offAllNamed('/login');
        }
      } else if (response.status == "error") {
        SnackbarUtil.error("Nomor atau Email tersebut sudah terpakai");
      } else {
        throw "Terjadi Kesalahan Coba Lagi...";
      }
    } catch (e) {
      if (e.toString() ==
          "[firebase_auth/invalid-verification-code] The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again.") {
        SnackbarUtil.error("Otp Invalid");
      }
      print(e);
      SnackbarUtil.error("$e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveInitialLoginData(LoginModel.LoginResponse userData) async {
    await _storage.write('token', userData.token);
  }
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => message;
}
