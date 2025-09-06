import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ControllerMenu extends GetxController {
  late PersistentTabController tabController;
  

  @override
  void onInit() {
    tabController = PersistentTabController(initialIndex: 0);
    super.onInit();
  }

  void goToTab(int index) {
    tabController.jumpToTab(index);
  }
}
