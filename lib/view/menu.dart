import 'package:cleaning_app/view/menu/booking/booking.dart';
import 'package:cleaning_app/view/menu/home.dart';
import 'package:cleaning_app/view/menu/profile.dart';
import 'package:cleaning_app/view/support.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../controller/menu.dart';
import 'menu/notification.dart';

class Menu extends StatelessWidget {
   Menu({super.key});
   final ControllerMenu menuController = Get.find<ControllerMenu>();

   final List<PersistentTabConfig> _tabs = [
    PersistentTabConfig(
       screen: Home(),
       item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
     ),
     PersistentTabConfig(
       screen: Booking(),
       item: ItemConfig(icon: Icon(Icons.calendar_month_rounded), title: "Booking"),
     ),
     PersistentTabConfig(
       screen: NotificationPage(),
       item: ItemConfig(icon: Icon(Icons.notifications), title: "Notification"),
     ),
     PersistentTabConfig(
       screen: SupportPage(),
       item: ItemConfig(icon: Icon(Icons.headset_mic_rounded), title: "Support"),
     ),
     PersistentTabConfig(
       screen: ProfilePage(),
       item: ItemConfig(icon: Icon(Icons.person), title: "Profile"),
     ),
    //  PersistentTabConfig(
    //    screen: Home(key: PageStorageKey("HomeTab")),
    //    item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
    //  ),
    //  PersistentTabConfig(
    //    screen: Booking(key: PageStorageKey("BookingTab")),
    //    item: ItemConfig(icon: Icon(Icons.calendar_month_rounded), title: "Booking"),
    //  ),
    //  PersistentTabConfig(
    //    screen: NotificationPage(key: PageStorageKey("NotificationTab")),
    //    item: ItemConfig(icon: Icon(Icons.notifications), title: "Notification"),
    //  ),
    //  PersistentTabConfig(
    //    screen: SupportPage(key: PageStorageKey("SupportTab")),
    //    item: ItemConfig(icon: Icon(Icons.headset_mic_rounded), title: "Support"),
    //  ),
    //  PersistentTabConfig(
    //    screen: ProfilePage(key: PageStorageKey("ProfileTab")),
    //    item: ItemConfig(icon: Icon(Icons.person), title: "Profile"),
    //  ),
   ];
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        controller: menuController.tabController,
        gestureNavigationEnabled: true,
        tabs: _tabs,
        backgroundColor: Colors.white,
        stateManagement: false,
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
              navBarConfig: navBarConfig,
            ));
  }
}
