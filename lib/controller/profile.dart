import 'dart:io';

import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../api.dart';
import '../widget/popup.dart';

class ProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final ktpAddressController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxString urlAvatar = ''.obs;
  final RxBool hasVoucher = false.obs;
  final RxInt valueVoucher = 0.obs;
  final RxString levelMember = "".obs;

  var percentageData = 0.0.obs;

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
    ktpAddressController.dispose();
    super.onClose();
  }

  void shareApp() {
    SharePlus.instance.share(ShareParams(
      text: 'Yuk pakai aplikasi Utilizes GO!\n'
          'Download di sini:\n'
          'https://play.google.com/store/apps/details?id=com.utilizes.gocleaning',
      subject: 'Bagikan Aplikasi Utilizes GO',
    ));
  }

  Future<void> getDetailUser() async {
    if (isClosed) return; // ✅ Cegah update jika controller sudah dispose

    try {
      print("get detail user");
      final response = await Api.getDetailUser();

      if (isClosed) return; // ✅ Cek lagi setelah await

      if (response.status == "success") {
        // Update reactive variable
        username.value = response.data!.firstName ?? "";
        email.value = response.data!.email ?? "";
        urlAvatar.value = response.data!.avatarPath ?? "";
        hasVoucher.value = response.data!.discMember != 0 ? true : false;
        valueVoucher.value = response.data!.discMember ?? 0;
        final level = response.data!.level ?? "";
        levelMember.value =
            level[0].toUpperCase() + level.substring(1).toLowerCase();

        // Update TextEditingController hanya jika controller masih aktif
        firstNameController.text = response.data!.firstName ?? "";
        lastNameController.text = response.data!.lastName ?? "";
        emailController.text = response.data!.email ?? "";
        ktpAddressController.text = response.data!.ktpAddress ?? "";

        // Hitung persentase kelengkapan data
        int filledCount = 0;
        if (firstNameController.text.trim().isNotEmpty) filledCount++;
        if (lastNameController.text.trim().isNotEmpty) filledCount++;
        if (emailController.text.trim().isNotEmpty) filledCount++;
        if (ktpAddressController.text.trim().isNotEmpty) filledCount++;

        percentageData.value = (filledCount / 4) * 100;
        print(
            "Terisi: $filledCount/4 (${percentageData.value.toStringAsFixed(0)}%)");
      } else {
        if (!isClosed) SnackbarUtil.error("Gagal get detail user");
      }
    } catch (e) {
      if (!isClosed) {
        print('Get Detail User Error: $e');
        SnackbarUtil.error("Terjadi kesalahan: $e");
      }
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
        SnackbarUtil.error("Gagal kompres gambar.");
        return;
      }
      imageFile.value = File(compressedFile!.path);
      final response = await Api.updateAvatar(imageFile.value!);
      if (response.status == "success") {
        urlAvatar.value = response.data!.avatarPath!;
        SnackbarUtil.success("Avatar updated!");
      } else {
        print("Response message: ${response.message}");
        SnackbarUtil.error("Failed to upload avatar");
      }
    } catch (e) {
      print('Update Avatar Error: $e');
      SnackbarUtil.error("Terjadi kesalahan: $e");
    }
  }

  Future<void> updateDetailUser() async {
    try {
      var data = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        // "born_place": bornPlaceController.text,
        // "bod": bodController.text,
        // "religion": religionController.text,
        "ktp_address": ktpAddressController.text,
      };
      isLoading.value = true;
      final response = await Api.updateDetailUser(data);
      if (response.status == "success") {
        SnackbarUtil.success("Data updated!");
        update();
      } else {
        SnackbarUtil.error("Gagal Update");
      }
    } catch (e) {
      print('Update Data Error: $e');
      SnackbarUtil.error("Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void clearImage() {
    imageFile.value = null;
  }

  // Future<void> selectDate(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
  //
  //   if (pickedDate != null) {
  //     bodController.text =
  //       "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
  //   }
  // }
}
