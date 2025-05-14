import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../api.dart';

class ProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final bornPlaceController = TextEditingController();
  final bodController = TextEditingController();
  final religionController = TextEditingController();
  final ktpAddressController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxString username = ''.obs;
  final RxString urlAvatar = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getDetailUser();
  }
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    bornPlaceController.dispose();
    bodController.dispose();
    religionController.dispose();
    ktpAddressController.dispose();
    super.onClose();
  }

  Future<void> getDetailUser() async {
    try {
      print("get detail user");
      final response = await Api.getDetailUser();
      if (response.status == "success") {
        username.value = response.data!.firstName ?? "";
        urlAvatar.value = response.data!.avatarPath ?? "";
        firstNameController.text = response.data!.firstName ?? "";
        lastNameController.text = response.data!.lastName ?? "";
        emailController.text = response.data!.email ?? "";
        bornPlaceController.text = response.data!.bornPlace ?? "";
        bodController.text = response.data!.bod ?? "";
        religionController.text = response.data!.religion ?? "";
        ktpAddressController.text = response.data!.ktpAddress ?? "";
      }else{
        Get.snackbar("Error", "Gagal get detail user");
      }
    } catch (e) {
      print('Get Detail User Error: $e');
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  final ImagePicker _picker = ImagePicker();
  var imageFile = Rxn<File>();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) return;

      File tempFile = File(pickedFile.path);

      String targetPath =
          '${tempFile.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

      var compressedFile = await FlutterImageCompress.compressAndGetFile(
        tempFile.path,
        targetPath,
        minWidth: 400,
        quality: 50, // Reduce quality for compression
      );

      if (compressedFile == null) {
        Get.snackbar("Error", "Gagal kompres gambar.");
        return;
      }
      imageFile.value = File(compressedFile!.path);
      final response = await Api.updateAvatar(imageFile.value!);
      if (response.status == "success") {
        urlAvatar.value = response.data!.avatarPath!;
        Get.snackbar("Success", "Avatar updated!");
      } else {
        print("Response message: ${response.message}");
        Get.snackbar("Error", "Failed to upload avatar");
      }
    } catch (e) {
      print('Update Avatar Error: $e');
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  Future<void> updateDetailUser()async {
    try{
      var data = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "born_place": bornPlaceController.text,
        "bod": bodController.text,
        "religion": religionController.text,
        "ktp_address": ktpAddressController.text,
      };
      isLoading.value = true;
      final response = await Api.updateDetailUser(data);
      if (response.status == "success") {
        Get.snackbar("Success", "Data updated!");
        update();
      }  else{
        Get.snackbar("Error", "Gagal Update");
      }
    }catch(e){
      print('Update Data Error: $e');
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }finally{
      isLoading.value = false;
    }

  }

  void clearImage() {
    imageFile.value = null;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      bodController.text =
        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    }
  }
}
