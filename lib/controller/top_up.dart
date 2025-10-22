import 'dart:io';

import 'package:cleaning_app/api.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TopUpController extends GetxController {
  var topupText = ''.obs;
  var isLoading = false.obs;
  // var listBank = ["bca", "mandiri"].obs;
  var listBank = <Map<String, String>>[
    {
      'bank_name': 'BCA',
      'account_number': '168 0370 628',
    },
    // {
    //   'bank_name': 'Mandiri',
    //   'account_number': '23455434543454423',
    // },
  ].obs;
  // var selectBank = ''.obs;
  var selectBank = Rx<Map<String, String>?>(null);

  var showError = false.obs;
  final ImagePicker _picker = ImagePicker();
  var imageDocument = Rx<File?>(null);

  int getRawValue(String text) {
    return int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }

  void onChanged(String value) {
    final amount = getRawValue(value);
    showError.value = amount < 20000;
    if (topupText.value != value) {
      topupText.value = value;
    }
  }

  Future<void> pickBuktiTopup() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
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
      imageDocument.value = File(compressedFile!.path);
    } catch (e) {
      print('Upload Bukti Error: $e');
      SnackbarUtil.error("Terjadi kesalahan: $e");
    }
  }

  Future<void> uploadDocumentTopup(String nominal) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      isLoading.value = true;

      final response = await Api.uploadBuktiTopup(
          formattedDate, nominal, imageDocument.value!);

      if (response.status == true) {
        //
        imageDocument.value = null;
        isLoading.value = false;
        topupText.value = "";
        Get.offNamed("/topup-success");
      } else {
        SnackbarUtil.error("Upload Gagal: ${response.message}");
      }
    } catch (e) {
      SnackbarUtil.error("Upload gagal: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
