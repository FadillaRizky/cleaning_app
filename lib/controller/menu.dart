import 'package:cleaning_app/controller/profile.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ControllerMenu extends GetxController {
  late PersistentTabController tabController;
  final ProfileController profileController = Get.find<ProfileController>();
  

  @override
  void onInit() {
    tabController = PersistentTabController(initialIndex: 0);
    profileController.getDetailUser();
    super.onInit();
  }

  void goToTab(int index) {
    tabController.jumpToTab(index);
  }
}
