import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cleaning_app/model/GetListOrderResponse.dart' as Data;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../api.dart';
import '../model/DetailOrderResponse.dart';

class BookingController extends GetxController {
  var detailOrder = Rxn<DetailOrderResponse>();
  var currentStep = 0.obs;
  var selectedIndex = 1.obs;
  var selectedStatus = "aktif".obs;
  var isLoading = false.obs;
  var listOrder = <Data.Data>[].obs;

  var status = <String>[
    "Menunggu Verifikasi",
    "Aktif",
    "Selesai",
    "Cancel",
  ];

  var steps = [
    LineIcons.broom,
    Icons.motorcycle_outlined,
    Icons.home,
    LineIcons.broom,
    Icons.check_circle,
  ].obs;

  String getStatusOrder() {
    switch (currentStep.value) {
      case 0:
        return 'Open';
      case 1:
        return 'Picked';
      case 2:
        return 'Arrived';
      case 3:
        return 'Progress';
      case 4:
        return 'Finish';
      default:
        return 'Status Tidak Dikenal';
    }
  }

  String getDescriptionOrder() {
    switch (currentStep.value) {
      case 0:
        return 'Kami sudah\nmenerima pesananmu';
      case 1:
        return 'Mitra kami segera\nmenuju lokasi';
      case 2:
        return 'Mitra kami sudah\nsampai lokasi';
      case 3:
        return 'Orderan sedang\ndikerjakan Mitra';
      case 4:
        return 'Orderan sudah selesai';
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

  Future<void> fetchDetailOrder() async {
    final id = Get.arguments;
    try {
      final response = await Api.getDetailOrder(id.toString());
      detailOrder.value = response;

      // update currentStep
      final statusToStep = {
        "open": 0,
        "picked": 1,
        "arrived": 2,
        "progress": 3,
        "finish": 4,
      };
      currentStep.value = statusToStep[response.data!.orderStatus] ?? 0;
    } catch (e) {
      // handle error
      print(e);
    }
  }

  Future<void> cancelOrder(Map<String, dynamic> data) async {
    try {
      EasyLoading.show();
      var response = await Api.cancelOrder(data);
      if (response.status == true) {
        Get.back();
        Get.back(result: true);
        EasyLoading.showSuccess(
            "Berhasil Cancel Order ${response.data!.category}");
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
