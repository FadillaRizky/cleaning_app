

import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/ListPackageResponse.dart';
import 'package:get/get.dart';

import '../api.dart';

class PackageController extends GetxController {

  Future<ListPackageResponse> getlistPackage() {
    return Api.getPackageList();
  }
}