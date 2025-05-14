import 'package:cleaning_app/controller/detail_daily_cleaning.dart';
import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/controller/register.dart';
import 'package:get/get.dart';

import 'controller/login.dart';
import 'controller/profile.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController());
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
    Get.lazyPut(() => HomeController());
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