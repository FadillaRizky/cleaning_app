import 'package:cleaning_app/view/menu/booking.dart';
import 'package:cleaning_app/view/menu/home.dart';
import 'package:cleaning_app/view/menu/profile.dart';
import 'package:cleaning_app/view/support.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        gestureNavigationEnabled: true,
        tabs: [
          PersistentTabConfig(
            screen: Home(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: Booking(),
            item: ItemConfig(
              icon: Icon(Icons.calendar_month_rounded),
              title: "Booking",
            ),
          ),

          PersistentTabConfig(
            screen: Home(),
            item: ItemConfig(
              icon: Icon(Icons.notifications),
              title: "Notification",
            ),
          ),
          PersistentTabConfig(
            screen: SupportPage(),
            item: ItemConfig(
              icon: Icon(Icons.headset_mic_rounded),
              title: "Support",
            ),
          ),
          PersistentTabConfig(
            screen: ProfilePage(),
            item: ItemConfig(
              icon: Icon(Icons.person),
              title: "Profile",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style6BottomNavBar(
              navBarConfig: navBarConfig,
            ));
  }
}
