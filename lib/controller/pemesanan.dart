import 'dart:io';
import 'dart:typed_data';

import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:cleaning_app/widget/utils.dart';
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
  var listAddressFuture = Rx<Future<PropertyAddressResponse>?>(null);
  PackageController packController = Get.find<PackageController>();
  var isProcessing = false.obs;
  var isOrdering = false.obs;

  var dateText = ''.obs;
  var timeText = ''.obs;
  var genderMitra = ['Pria', 'Wanita', 'Random'].obs;
  var selectedGender = "".obs;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var noteController = TextEditingController();
  final FocusNode noteFocus = FocusNode();

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

  void handleBack() {
    imageDocument.value = null;
    Get.back();
  }

  void refreshAddress() {
    listAddressFuture.value = Api.getAddress();
    update(); // for GetBuilder
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(pickedDate);
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
            String formattedTimeData = '${time.hour.toString().padLeft(2, '0')}:'
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
        result["data_pack[$i][object_id][$j]"] = objects[j]["object_id"].toString();
      }

      // // object_price
      // for (int j = 0; j < objects.length; j++) {
      //   result["data_pack[$i][object_price][$j]"] =
      //       objects[j]["object_price"].toString();
      // }

      for (int j = 0; j < objects.length; j++) {
        result["data_pack[$i][qty_object][$j]"] = objects[j]["object_amount"].toString();
      }
    }
    print("body : $result");
    return result;
  }

  void confirmPayment(Map<String, dynamic> data) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(30.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 140.r,
                height: 140.r,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LineIcons.wallet,
                  color: Colors.blue,
                  size: 70.r,
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                "Konfirmasi Pembayaran",
                style: TextStyle(
                  fontSize: 52.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Apakah Anda yakin ingin melanjutkan pembayaran?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Pastikan nominal dan detail pesanan sudah benar sebelum melanjutkan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 35.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 22.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                      ),
                      onPressed: isOrdering.value
                          ? null
                          : () {
                              isProcessing.value = false;
                              Get.back();
                            },
                      child: isOrdering.value
                          ? CircularProgressIndicator()
                          : Text(
                              "Periksa Lagi",
                              style: TextStyle(fontSize: 36.sp, color: Colors.black54),
                            ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(child: Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 22.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                      ),
                      onPressed: isOrdering.value
                          ? null
                          : () async {
                              // isLoading.value = true ;
                              await orderPackage(data);
                            },
                      child: isOrdering.value
                          ? CircularProgressIndicator()
                          : Text(
                              "Ya, Lanjutkan",
                              style: TextStyle(
                                fontSize: 36.sp,
                                color: Colors.white,
                              ),
                            ),
                    );
                  })),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> orderPackage(Map<String, dynamic> data) async {
    if (isOrdering.value) return;
    try {
      isOrdering.value = true;
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
      isOrdering.value = false;
      isProcessing.value = false;
    }
  }

  Future<void> handlePayment({
    required int total,
    required int saldo,
  }) async {
    if (isProcessing.value) return;

    isProcessing.value = true;

    try {
      if (!validateInput()) return;

      if (!validateDateTime()) return;

      final totalHarga = calculateTotal(total);

      if (selectedPayment.value == "Saldo") {
        if (!validateBalance(saldo, totalHarga)) return;

        final data = buildOrderData("Saldo");

        confirmPayment(data);

        return;
      }

      goToPaymentPage(totalHarga);
    } finally {
      isProcessing.value = false;
    }
  }

  Map<String, dynamic> buildOrderData(String paymentMethod) {
    final isDaily = packController.category.value == "Daily Cleaning" ||
        packController.category.value == "InCarely";

    final Map<String, dynamic> data = {
      "category": packController.category.value,
      "due_date": dateText.value,
      "due_time": timeText.value,
      "order_notes": noteController.text,
      "property_id": propertyId.value,
      "property_city": Utils.extractSecondSentence(
        propertyAddress.value,
      ),
      "mitra_gender": selectedGender.value,
      "payment_type": paymentMethod == "Saldo"
          ? "balance"
          : paymentMethod == "QRIS"
              ? "qris"
              : "bank transfer",
    };

    if (isDaily) {
      data.addAll({
        "data_pack[0][pack_id]": packController.selectedPackageId.value,
        "data_pack[0][pack_category]": packController.category.value,
        "data_pack[0][ph_id]": packController.selectedPhId.value,
        "data_pack[0][object_id]": "",
        "data_pack[0][object_price]": "",
      });
    } else {
      data.addAll(getListDataPack());
    }

    return data;
  }

  void goToPaymentPage(int totalHarga) {
    Get.toNamed(
      "/tagihan",
      arguments: {
        "metode_pembayaran": selectedPayment.value,
        "total_harga": totalHarga,
      },
    );
  }

  bool validateDocument() {
    if (imageDocument.value == null) {
      SnackbarUtil.show(
        "Tambahkan bukti pembayaran",
        "Anda belum mengunggah bukti transfer. Harap unggah bukti pembayaran untuk melanjutkan.",
      );
      return false;
    }
    return true;
  }

  bool validateInput() {
    if (propertyId.value.isEmpty) {
      SnackbarUtil.show(
        "Alamat Kosong",
        "Silakan tambahkan alamat terlebih dahulu",
      );
      return false;
    }

    if (dateText.value.isEmpty) {
      SnackbarUtil.show(
        "Tanggal Layanan Kosong",
        "Silakan pilih tanggal layanan terlebih dahulu",
      );
      return false;
    }

    if (timeText.value.isEmpty) {
      SnackbarUtil.show(
        "Waktu Layanan Kosong",
        "Silakan pilih waktu layanan terlebih dahulu",
      );
      return false;
    }

    if (selectedGender.value.isEmpty) {
      SnackbarUtil.show(
        "Gender Mitra Kosong",
        "Silakan pilih preferensi gender mitra",
      );
      return false;
    }

    if (selectedPayment.value.isEmpty) {
      SnackbarUtil.show(
        "Metode Pembayaran",
        "Silakan pilih metode pembayaran",
      );
      return false;
    }

    return true;
  }

  int calculateTotal(int total) {
    final isDaily = packController.category.value == "Daily Cleaning" ||
        packController.category.value == "InCarely";

    final apartmentFee = propertyType.value == "Apartement" ? 20000 : 0;

    final packagePrice = isDaily ? int.parse(packController.selectedDiscountPrice.value) : total;

    return packagePrice + apartmentFee + 2000;
  }

  bool validateBalance(
    int saldo,
    int totalHarga,
  ) {
    if (saldo >= totalHarga) return true;

    SnackbarUtil.show(
      "Saldo Tidak Mencukupi",
      "Silakan top up saldo terlebih dahulu",
    );

    return false;
  }

  bool validateDateTime() {
    try {
      final selectedDate = DateTime.parse(dateText.value);

      final parts = timeText.value.split(':');

      final selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (selectedDateTime.isBefore(DateTime.now())) {
        SnackbarUtil.show(
          "Waktu Tidak Valid",
          "Waktu layanan yang dipilih sudah lewat.",
        );

        return false;
      }

      return true;
    } catch (e) {
      SnackbarUtil.show(
        "Data Tidak Valid",
        e.toString(),
      );

      return false;
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

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    timeController.dispose();
    noteController.dispose();
    noteFocus.dispose();
  }
}
