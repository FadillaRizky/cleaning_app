import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api.dart';

class PemesananController extends GetxController {
  late Future<PropertyAddressResponse> listAddressFuture;
  PackageController packController = Get.find<PackageController>();
  var isLoading = false.obs;
  var dateText = ''.obs;
  var timeText = ''.obs;
  var genderMitra = ['Laki - Laki', 'Perempuan', 'Bebas'].obs;
  var selectedGender = "".obs;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var noteController = TextEditingController();

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
      firstDate: DateTime(2000),
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

  Future<void> orderPackage(Map<String, dynamic> data) async {
    print(data);
    try {
      EasyLoading.show();
      print("aaa");
      final response = await Api.orderPackage(data);
      if (response.status == true) {
        Get.offNamed("/booking-success",arguments: response.data!.orderid);
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
}
