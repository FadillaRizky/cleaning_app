import 'package:cleaning_app/model/ListCategoryPackageResponse.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final _storage = GetStorage();
  RxString userName = ''.obs;

  late Future<ListCategoryPackageResponse> futurePackageList;
  var options = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    futurePackageList = Api.getCategoryPackageList();
    userName.value = _storage.read('name') ?? 'Anonymous';
    super.onInit();
  }

  Future<void> refreshPackage() async {
    // await Future.delayed(Duration(seconds: 2));
      futurePackageList = Api.getCategoryPackageList();
      update();
  }
}