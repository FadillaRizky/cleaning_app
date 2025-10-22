import 'package:cleaning_app/api.dart';
import 'package:get/get.dart';

import '../model/DetailOrderResponse.dart';

class InvoiceController extends GetxController {
  Future<DetailOrderResponse> getDetailorder() {
    final id = Get.arguments;
    print(id);
    return Api.getDetailOrder(id.toString());
  }
}
