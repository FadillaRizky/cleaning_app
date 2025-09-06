import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cleaning_app/model/ListCategoryPackageResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../model/HistoryTransaksiResponse.dart';
import '../widget/popup.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final _storage = GetStorage();
  RxString userName = ''.obs;

  late Future<ListCategoryPackageResponse> futurePackageList;
  var options = <Map<String, dynamic>>[].obs;

  ///Banner
  final CarouselSliderController carouselController =
      CarouselSliderController();
  var isBannerLoading = false.obs;
  var banner = <String>[].obs;

  ///keterangan Notif
  var notifLength = 0.obs;

  /// Keterangan Jumlah Saldo
  var amountSaldo = "".obs;

  /// Top up Saldo
  var isLoading = false.obs;
  var topupText = ''.obs;
  // var listBank = ["bca", "mandiri"].obs;
  var listBank = <Map<String, String>>[
    {
      'bank_name': 'BCA',
      'account_number': '62789947384784333',
    },
    {
      'bank_name': 'Mandiri',
      'account_number': '23455434543454423',
    },
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
    topupText.value = value;
    final amount = getRawValue(value);
    showError.value = amount < 20000;
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
        Get.toNamed("/topup-success");
      } else {
        SnackbarUtil.error("Upload Gagal: ${response.message}");
      }
    } catch (e) {
      SnackbarUtil.error("Upload gagal: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPackage() async {
    // await Future.delayed(Duration(seconds: 2));
    futurePackageList = Api.getCategoryPackageList();
    fetchSaldo();
    fetchNotif();
    update();
  }

  Future<void> fetchSaldo() async {
    try {
      isLoading.value = true;

      final response = await Api.getSaldo();
      print(response.data!.totalBalance);
      if (response.status == true) {
        amountSaldo.value = response.data!.totalBalance == null ? "0" : response.data!.totalBalance.toString() ;
      }
    } catch (e) {
      print("gagal get saldo : $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<HistoryTransaksiResponse> fetchHistoryTransaksi() {
    return Api.getHistoryTransaksi();
  }

  String getGreetingByTime() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    if (hour >= 5 && (hour < 9 || (hour == 9 && minute == 0))) {
      return "Pagi";
    } else if ((hour == 9 && minute >= 1) ||
        (hour > 9 && hour < 14) ||
        (hour == 14 && minute == 0)) {
      return "Siang";
    } else if ((hour == 14 && minute >= 1) ||
        (hour > 14 && hour < 18) ||
        (hour == 18 && minute == 0)) {
      return "Sore";
    } else {
      return "Malam";
    }
  }

  Future<void> fetchNotif() async {
    try {
      isLoading.value = true;

      final response = await Api.getNotification();
      if (response.status == true) {
        notifLength.value =
            response.data!.where((item) => item.status == "0").length;
      }
    } catch (e) {
      print("gagal get notif : $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBanner() async {
    try {
      isBannerLoading.value = true;

      final response = await Api.getBanner();
      if (response.status == true) {
        banner.value = response.data!
            .where((item) => item.bannerStatus == "active")
            .map<String>((item) => item.bannerPath.toString())
            .toList();
      }
    } catch (e) {
      print("gagal get banner : $e");
    } finally {
      isBannerLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    futurePackageList = Api.getCategoryPackageList();
    fetchSaldo();
    userName.value = _storage.read('name') ?? 'Anonymous';
    fetchNotif();
    getBanner();
  }
}
