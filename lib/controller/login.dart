import 'package:cleaning_app/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api.dart';
import '../main.dart';
import '../model/LoginResponse.dart' as LoginModel;
import '../view/login.dart';
import '../view/menu.dart';

class LoginController extends GetxController {
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final _storage = GetStorage();

  late TextEditingController controllerphoneNumber;
  late TextEditingController controllerPassword;

  final Rx<LoginModel.LoginResponse?> loginResponse =
      Rx<LoginModel.LoginResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    print("LOGIN CONTROLLER onInit CALLED");
    controllerphoneNumber = TextEditingController();
    controllerPassword = TextEditingController();
  }

  @override
  void onClose() {
    print("LOGIN CONTROLLER onClose CALLED");
    controllerphoneNumber.dispose();
    controllerPassword.dispose();
    super.onClose();
  }

  Future<void> loginUser() async {
    var phoneNumber = controllerphoneNumber.text.trim();
    var password = controllerPassword.text.trim();

    var data = {
      "phone_number": "+62${phoneNumber}",
      "password": password,
    };

    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (phoneNumber.isEmpty || password.isEmpty) {
        throw 'Nomor HP & Password tidak boleh kosong';
      }

      final response = await Api.login(data);
      // loginResponse.value = response;
      print(
          'Login Response: ${response.toJson()}'); // Log the entire response for debugging

      if (response.status == "success" && response.data != null) {
        print(response.refreshToken);
        await _saveInitialLoginData(response); // Assuming this method exists

        Get.offAllNamed('/menu');
      } else {
        errorMessage.value =
            response.message ?? 'Terjadi kesalahan saat login.';
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print('Login Controller Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveInitialLoginData(LoginModel.LoginResponse userData) async {
    await _storage.write('name', userData.data!.firstName);
    await _storage.write('email', userData.data!.email);
    await _storage.write('token', userData.token);
    await _storage.write('refresh_token', userData.refreshToken);
  }

  Future<void> _removeInitialLoginData() async {
    await _storage.remove('name');
    await _storage.remove('email');
    await _storage.remove('token');
    await _storage.remove('refresh_token');
  }

  void logout() async {
    Get.dialog(
      AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _removeInitialLoginData();
              Get.offAllNamed('/login');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
