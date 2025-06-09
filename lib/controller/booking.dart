

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cleaning_app/model/GetListOrderResponse.dart' as Data;

import '../api.dart';
import '../model/DetailOrderResponse.dart';

class BookingController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedStatus = "open".obs;
  var isLoading = false.obs;
  var listOrder = <Data.Data>[].obs;

  var status = <String>[
    "Open",
    "Pick Up",
    "Progress",
    "Completed",
    "Cancel",
  ];

  @override
  void onInit() {
    super.onInit();
getListOrder();
  }

  Future<void> getListOrder()async{
    try {
      isLoading.value = true;

      final response = await Api.getListOrder();
      if (response.status == true) {
        listOrder.assignAll(response.data ?? []);
      }else{
        EasyLoading.showError("Gagal Get List Order");
      }
    } catch (e) {
      print("gagal Get List Order : $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<DetailOrderResponse> getDetailorder(){
    final id = Get.arguments;
    return Api.getDetailOrder(id.toString());
  }

}