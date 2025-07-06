import 'package:cleaning_app/controller/home.dart';
import 'package:get/get.dart';

import '../api.dart';
import '../model/GetNotificationResponse.dart';

class NotificationController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  late Future<GetNotificationResponse> futureGetNotif;

  Future<void> refreshNotif() async {
    final response =
        await Api.getNotification();
    futureGetNotif =
        Future.value(response);

    if (response.status == true) {
      homeController.notifLength.value =
          response.data!.where((item) => item.status == "0").length;
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    futureGetNotif = Api.getNotification();
  }
}
