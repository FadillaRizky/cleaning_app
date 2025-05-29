

import 'package:get/get.dart';

class BookingController extends GetxController {
  var selectedIndex = 0.obs;
  var status = <String>[
    "Upcoming",
    "Complete",
    "Cancel",
  ];

}