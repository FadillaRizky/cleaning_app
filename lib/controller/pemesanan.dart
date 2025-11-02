import 'dart:io';
import 'dart:typed_data';

import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
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

  void selectPayment(String select) {
    selectedPayment.value = select;
  }

  @override
  void onInit() {
    super.onInit();
    refreshAddress();
  }

  ///Property
  var picName = ''.obs;
  var propertyAddress = ''.obs;
  var propertyId = ''.obs;
  var propertyType = ''.obs;
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

  void selectTime(BuildContext context) async {
    Navigator.push(
        context,
        showPicker(
          context: context,
          value: Time(hour: 12, minute: 00, second: 00),
          sunrise: TimeOfDay(hour: 6, minute: 0),
          sunset: TimeOfDay(hour: 18, minute: 0),
          is24HrFormat: true,
          duskSpanInMinutes: 120,
          minHour: 0,
          maxHour: 23,
          onChange: (time) {
            String formattedTimeUI =
                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
            String formattedTimeData =
                '${time.hour.toString().padLeft(2, '0')}:'
                '${time.minute.toString().padLeft(2, '0')}:00';
            timeController.text = formattedTimeUI;
            timeText.value = formattedTimeData;
          },
        ));
  }

  Future<bool?> showConfirmDialog(String title, String message) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Ubah"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }

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

      // // object_price
      // for (int j = 0; j < objects.length; j++) {
      //   result["data_pack[$i][object_price][$j]"] =
      //       objects[j]["object_price"].toString();
      // }

      for (int j = 0; j < objects.length; j++) {
        result["data_pack[$i][qty_object][$j]"] =
            objects[j]["object_amount"].toString();
      }
    }
    print("body : $result");
    return result;
  }

  confirmPayment(Map<String, dynamic> data) {
    Get.defaultDialog(
  title: "Konfirmasi Pembayaran",
  titleStyle:  TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 50.sp,
    color: Colors.blueAccent,
  ),
  content: Column(
    children:  [
      Icon(
        LineIcons.wallet,
        color: Colors.blue,
        size: 150.r,
      ),
      SizedBox(height: 12),
      Text(
        "Apakah Anda yakin ingin melanjutkan pembayaran?",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 8),
      Text(
        "Pastikan nominal dan detail pesanan sudah benar sebelum melanjutkan.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 36.sp, color: Colors.grey),
      ),
    ],
  ),
  textCancel: "Periksa Lagi",
  textConfirm: "Ya, Lanjutkan",
  confirmTextColor: Colors.white,
  buttonColor: Colors.blue,
  barrierDismissible: true,
  radius: 12,
  onCancel: () {},
  onConfirm: () {
    orderPackage(data);
  },
);

  }

  Future<void> orderPackage(Map<String, dynamic> data) async {
    try {
      EasyLoading.show();
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
      EasyLoading.showInfo("$e");
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
