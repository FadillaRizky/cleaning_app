import 'package:cleaning_app/controller/profile.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MenuMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print("Route /menu dipanggil");

    // pastikan ProfileController sudah terdaftar (via lazyPut di MenuBindings)
    if (Get.isRegistered<ProfileController>()) {
      print("jalan");
      final profileC = Get.find<ProfileController>();
      profileC.getDetailUser(); // panggil tanpa await (fire-and-forget)
    }

    return null; // null = lanjut ke halaman tujuan seperti biasa
  }
}