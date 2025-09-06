import 'dart:io';
import 'dart:typed_data';

import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:saver_gallery/saver_gallery.dart';

import '../api.dart';

class PemesananController extends GetxController {
  late Future<PropertyAddressResponse> listAddressFuture;
  PackageController packController = Get.find<PackageController>();
  var isLoading = false.obs;
  var dateText = ''.obs;
  var timeText = ''.obs;
  var genderMitra = ['Pria', 'Wanita', 'Random'].obs;
  var selectedGender = "".obs;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var noteController = TextEditingController();

  var selectedPayment = "".obs;

  @override
  void onInit() {
    super.onInit();
    refreshAddress();
  }

  ///Property
  var picName = ''.obs;
  var propertyAddress = ''.obs;
  var propertyId = ''.obs;
  var selectedProperty = 0.obs;

  ///Upload bukti tagihan
  final ImagePicker _picker = ImagePicker();
  var imageDocument = Rx<File?>(null);


  // Future<PropertyAddressResponse> getDetailPackage() {
  //   return Api.getAddress();
  // }

  void refreshAddress() {
    listAddressFuture = Api.getAddress();
    update(); // for GetBuilder
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    if (pickedDate != null) {
      String formattedDate =
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(pickedDate);
      dateController.text = formattedDate;
      dateText.value = DateFormat('yyyy-MM-dd', 'id_ID').format(pickedDate);
      print(dateText);
    }
  }

  // List<Map<String, dynamic>> getListDataPack() {
  //   return packController.resultDataObject.map((pack) {
  //     return {
  //       "pack_id": pack["pack_id"].toString(),
  //       "pack_category": packController.category.value,
  //       "pack_hour": "0", // Default value
  //       "object_id": (pack["data_object"] as List)
  //           .map((obj) => obj["object_id"].toString())
  //           .toList(),
  //       "object_price": (pack["data_object"] as List)
  //           .map((obj) => obj["object_price"])
  //           .toList(),
  //     };
  //   }).toList();
  // }

  Map<String, dynamic> getListDataPack() {
    Map<String, dynamic> result = {};

    for (int i = 0; i < packController.resultDataObject.length; i++) {
      var pack = packController.resultDataObject[i];

      // nilai utama
      result["data_pack[$i][pack_id]"] = pack["pack_id"].toString();
      result["data_pack[$i][pack_category]"] = packController.category.value;
      result["data_pack[$i][pack_hour]"] = "0"; // default value

      // object_id
      var objects = pack["data_object"] as List;
      for (int j = 0; j < objects.length; j++) {
        result["data_pack[$i][object_id][$j]"] =
            objects[j]["object_id"].toString();
      }

      // object_price
      for (int j = 0; j < objects.length; j++) {
        result["data_pack[$i][object_price][$j]"] =
            objects[j]["object_price"].toString();
      }
    }

    return result;
  }

  confirmPayment(Map<String, dynamic> data) {
    Get.defaultDialog(
      title: "Konfirmasi Pembayaran",
      middleText:
          "Apakah Anda yakin telah menyelesaikan pembayaran?\n Harap pastikan jumlah transfer dan nomor tujuan benar. Transaksi akan dibatalkan apabila terdapat kesalahan.",
      textCancel: "Periksa Lagi",
      textConfirm: "Ya, Kirim",
      confirmTextColor: Colors.white,
      barrierDismissible: true,
      onCancel: () {},
      onWillPop: () async {
        return true;
      },
      onConfirm: () {
        orderPackage(data);
      },
      buttonColor: Colors.blue,
      radius: 10,
    );
  }

  Future<void> orderPackage(Map<String, dynamic> data) async {
    print(data);

    try {
      EasyLoading.show();
      print("aaa");
      final response = await Api.orderPackage(data, imageDocument.value);
      if (response.status == true) {
        Get.offNamed("/booking-success", arguments: response.data!.orderid);
        packController.resultDataObject.clear();
        packController.category.value = "";
        timeText.value = "";
        dateText.value = "";
        noteController.clear();
      } else {
        EasyLoading.showInfo("Order Gagal");
      }
    } catch (e) {
      print("gagal order package : $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> pickBuktiTransfer() async {
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

  Future<void> saveQrisToGallery(BuildContext context) async {
    try {
      // Ambil file dari assets
      final byteData = await rootBundle.load("assets/full_qris.jpg");

      // Simpan sementara ke direktori app
      final tempDir = await getTemporaryDirectory();
      final file = File("${tempDir.path}/QRIS.png");
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Simpan ke Gallery menggunakan saver_gallery
      final result = await SaverGallery.saveFile(
        fileName: "QRIS",
        filePath: file.path,
        skipIfExists: false,
      );

      if (result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("QRIS berhasil disimpan ke Gallery")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal menyimpan QRIS")),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
