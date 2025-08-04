import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cleaning_app/model/GetListOrderResponse.dart' as Data;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../api.dart';
import '../model/DetailOrderResponse.dart';

class BookingController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedStatus = "aktif".obs;
  var isLoading = false.obs;
  var listOrder = <Data.Data>[].obs;

  var status = <String>[
    "Aktif",
    "Completed",
    "Cancel",
  ];

  var currentStep = 0.obs;
  var steps = [
    LineIcons.broom,
    Icons.person,
    LineIcons.broom,
    Icons.home,
  ].obs;

  String getStatusOrder() {
    switch (currentStep.value) {
      case 0:
        return 'Order';
      case 1:
        return 'Menuju Lokasi';
      case 2:
        return 'Dalam Proses';
      case 3:
        return 'Selesai';
      default:
        return 'Status Tidak Dikenal';
    }
  }

  String getDescriptionOrder() {
    switch (currentStep.value) {
      case 0:
        return 'Kami sudah\nmenerima pesananmu';
      case 1:
        return 'Mitra kami segera\nmenuju lokasi anda';
      case 2:
        return 'Mitra kami sedang\nmenyelesaikan pekerjaan';
      case 3:
        return 'Klik tombol selesai\ndibawah untuk menyelesaikan';
      default:
        return 'Status Tidak Dikenal';
    }
  }

  @override
  void onInit() {
    super.onInit();
    getListOrder();
  }

  Future<void> getListOrder() async {
    try {
      isLoading.value = true;

      final response = await Api.getListOrder();
      if (response.status == true) {
        print(response.data!.length);
        listOrder.assignAll(response.data ?? []);
      } else {
        EasyLoading.showError("Gagal Get List Order");
      }
    } catch (e) {
      print("gagal Get List Order : $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<DetailOrderResponse> getDetailorder() {
    final id = Get.arguments;
    return Api.getDetailOrder(id.toString());
  }

  Future<void> cancelOrder(Map<String, dynamic> data) async {
    try {
      EasyLoading.show();
      var response = await Api.cancelOrder(data);
      if (response.status == true) {
        Get.back();
        Get.back(result: true);
        EasyLoading.showSuccess("Berhasil Cancel Order ${response.data!.category}");
      } else {
        EasyLoading.showError("Gagal Cancel Order");
      }
    } catch (e, stackTrace) {
      print("Error: $e");
      print("StackTrace: $stackTrace");
      EasyLoading.showError("Gagal : $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
