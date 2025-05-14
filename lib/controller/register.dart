import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api.dart';
import '../model/LoginResponse.dart' as LoginModel;
import '../view/login.dart';
import '../view/menu.dart';
import '../view/register_verify.dart';
import '../view/menu/home.dart';

class RegisterController extends GetxController {
  final RxBool isPasswordVisible = true.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingVerify = false.obs;
  final GetStorage _storage = GetStorage();
  final Rx<LoginModel.LoginResponse?> loginResponse = Rx<LoginModel.LoginResponse?>(null);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final otpControllers = List.generate(6, (index) => TextEditingController());
  final focusNodes = List.generate(6, (index) => FocusNode());

  Future<void> verifyRegister() async {
    isLoading.value = true;
    try {
      if (firstNameController.text.isEmpty) {
        throw "First Name Kosong";
      }
      if (lastNameController.text.isEmpty) {
        throw "Last Name Kosong";
      }
      if (phoneNumberController.text.isEmpty) {
        throw "Nomor HP Kosong";
      }
      if (emailController.text.isEmpty) {
        throw "Email Kosong";
      }
      if (passwordController.text.isEmpty) {
        throw "Password Kosong";
      }
      if (confirmPasswordController.text.isEmpty) {
        throw "Password Konfirmasi Kosong";
      }
      if (passwordController.text != confirmPasswordController.text) {
        throw "Password dan konfirmasi password tidak cocok";
      }

      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+62${phoneNumberController.text.trim()}',
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {},
        codeSent: (verificationId, forceResendingToken) {

          Get.toNamed(
            '/register-verify',
            arguments: {
              'noHp': '+62${phoneNumberController.text}',
              'verificationId': verificationId,
            },
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print("error");
        },
      );



    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM, // Show at bottom
      );
      print(e);
    }finally {
      isLoading.value = false;
    };
  }


  Future<void> register(String verificationId)async{
    isLoading.value = true;

    try {
      if (!otpControllers.every((controller) => controller.text.trim().isNotEmpty)) {
        throw "Otp Belum Terisi";
      }

      String otp = otpControllers
          .map((controller) => controller.text)
          .join();
      final cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(cred);

      var firstName = firstNameController.text.trim(); // Added trim() to remove leading/trailing whitespace
      var lastName = lastNameController.text.trim(); // Added trim() to remove leading/trailing whitespace
      var phoneNumber = phoneNumberController.text.trim();
      var email = emailController.text.trim();
      var password = passwordController.text.trim();

      var data = {
        "first_name" : firstName,
        "last_name" : lastName,
        "phone_number": "+62${phoneNumber}",
        "email": email,
        "password": password,
      };

      var loginData = {
        "phone_number":"+62${phoneNumber}",
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
      }
     else if (response.status == "error") {
        Get.snackbar(
          "Gagal",
          "Nomor atau Email tersebut sudah terpakai",
          snackPosition: SnackPosition.BOTTOM, // Show at bottom
        );
      }  
      else {
        throw "Terjadi Kesalahan Coba Lagi...";
      }


    } catch (e) {
      if (e.toString() == "[firebase_auth/invalid-verification-code] The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again.") {
        Get.snackbar(
          "Error",
          "Otp Invalid",
          snackPosition: SnackPosition.BOTTOM, // Show at bottom
        );
      }
      print(e);
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM, // Show at bottom
      );
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> _saveInitialLoginData(LoginModel.LoginResponse userData) async {
    await _storage.write('token', userData.token);
  }
}
