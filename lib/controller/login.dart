import 'package:cleaning_app/bindings.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      "phone_number": phoneNumber,
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
    // Get.dialog(
    //   AlertDialog(
    //     title: Text('Confirm Logout'),
    //     content: Text('Are you sure you want to log out?'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Get.back(); // Close the dialog
    //         },
    //         child: Text('Cancel'),
    //       ),
    //       TextButton(
    //         onPressed: () async {
    //           await _removeInitialLoginData();
    //           Get.offAllNamed('/login');
    //         },
    //         child: Text('Logout'),
    //       ),
    //     ],
    //   ),
    // );

     Get.dialog(
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon dengan animasi
              Container(
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(42.r),
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 100.r,
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                "Keluar dari akun?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.sp),
              ),
              SizedBox(height: 24.h),
              Text(
                "Apakah kamu yakin ?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 38.sp),
              ),
              SizedBox(height: 35.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 33.h),
                      ),
                      child: Text("Batal", style: TextStyle(fontSize: 38.sp)),
                    ),
                  ),
                  SizedBox(width: 36.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                        try {
                          EasyLoading.show(status: 'Keluar...');

                          final response = await Api.logout();

                          if (response.status == true) {
                            await _removeInitialLoginData();
                            EasyLoading.dismiss();
                            Get.offAllNamed('/login');
                          } else {
                            EasyLoading.dismiss();
                            SnackbarUtil.error(
                              "Terjadi kesalahan, coba lagi..",
                            );
                          }
                        } catch (e) {
                          EasyLoading.dismiss();
                          SnackbarUtil.error("Logout gagal: ${e.toString()}");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 33.h),
                      ),
                      child: Text("Keluar", style: TextStyle(fontSize: 38.sp)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: true,
    );
  }
}
