import 'package:cleaning_app/controller/alamat.dart';
import 'package:cleaning_app/controller/detail_daily_cleaning.dart';
import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/invoice.dart';
import 'package:cleaning_app/controller/menu.dart';
import 'package:cleaning_app/controller/notification.dart';
import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/controller/pemesanan.dart';
import 'package:cleaning_app/controller/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'controller/booking.dart';
import 'controller/login.dart';
import 'controller/profile.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ControllerMenu(), fenix: true);

  }
}

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(), fenix: true);
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerMenu(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => BookingController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
  }
}

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}

class DetailPackageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackageController(), fenix: true);
  }
}
class DetailDailyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailDailyController(), fenix: true);
  }
}

class PemesananBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PemesananController(), fenix: true);
  }
}

class AlamatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlamatController(), fenix: true);
  }
}

class InvoiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoiceController(), fenix: true);
  }
}