

import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/ListPackageResponse.dart';
import 'package:cleaning_app/model/ObjectPackageResponse.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:get/get.dart';

import '../api.dart';

class PackageController extends GetxController {
  var category = "".obs;

  RxList<bool> selectPackageDeep = <bool>[].obs;
  RxList<bool> selectObjectPackage = <bool>[].obs;

  RxList<Map<String, dynamic>> tempDataObject = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> resultDataObject = <Map<String, dynamic>>[].obs;

  ///Daily Cleaning Section
  var selectedPackageId = ''.obs;
  var selectedPackageImg = ''.obs;
  var selectedPackageName = ''.obs;
  var selectedDiscount = ''.obs;
  var selectedPriceDuration = ''.obs;
  var selectedDuration = ''.obs;

  Future<Map<String, dynamic>> getDetailPackage(String id) async{
    final dataDetail = await Api.getDetailPackage(id);
    final dataDuration = await Api.getDurationPackage(id);
    // final dataProperty = await Api.getAddress();
    return {
      'data_detail': dataDetail,
      'data_duration': dataDuration,
    };

  }

  /// Deep Cleaning Section
  String amountObjectPrice(){
    var amount = tempDataObject.fold(
        0, (sum, item) {
      return sum + int.parse(item["object_price"]);
    });

    return Utils.formatCurrency(amount);
  }

   amountItemperPackage(num id){
    final matchedPack = resultDataObject.firstWhere(
          (element) => element["pack_id"] == id,
      orElse: () => {},
    );
    print("matchedPack : $matchedPack");

    if (matchedPack.isNotEmpty && matchedPack["data_object"] is List) {
      return matchedPack["data_object"].length;
    } else {
      return 0;
    }
  }

  amountPriceperPackage(num id){
    final matchedPack = resultDataObject.firstWhere(
          (element) => element["pack_id"] == id,
      orElse: () => {},
    );
    // print(matchedPack);

    if (matchedPack.isNotEmpty && matchedPack["data_object"] is List) {
      return matchedPack["data_object"].fold(0, (total, item) {
        final price = int.tryParse(item['object_price'].toString()) ?? 0;
        return total + price;
      });
    } else {
      return 0;
    }
  }

  Future<ObjectPackageResponse> getObjectPackage(String pack_id) async{

    final response = await Api.getObjectPackage(pack_id);

    final existingPack = resultDataObject.firstWhere(
          (element) => element["pack_id"].toString() == pack_id,
      orElse: () => {},
    );

    List<bool> tempSelect = [];

    if (existingPack.isNotEmpty) {
      // Ambil daftar object_id dari data_object di resultDataObject
      final existingObjectIds = (existingPack["data_object"] as List)
          .map((e) => e["object_id"])
          .toList();

      // Buat list bool berdasarkan apakah object_id ditemukan di existingObjectIds
      tempSelect = response.data!
          .map((e) => existingObjectIds.contains(e.objectId))
          .toList();
      tempDataObject.addAll(existingPack["data_object"]);
    } else {
      // Jika tidak ada, semua di-set false
      tempSelect = List<bool>.filled(response.data!.length, false);
    }

    // Set nilai
    selectObjectPackage.value = tempSelect;

    return response;
  }



  void addResultDataObject(int packId,String packName,String packImg, List<Map<String, dynamic>> newDataObject) {
    final index = resultDataObject.indexWhere((element) => element["pack_id"] == packId);

    if (index != -1) {
      resultDataObject[index] = {
        ...resultDataObject[index],
        "data_object": newDataObject
      };
    } else {
      resultDataObject.add({
        "pack_id": packId,
        "pack_name": packName,
        "pack_img": packImg,
        "data_object" : newDataObject
      });
    }
  }

  /// Common Section
  Future<ListPackageResponse> getlistPackage(String category) async{
    final response = await Api.getPackageList(category);

    if (category == "Deep Cleaning" && response.data != null) {
      selectPackageDeep.value = List<bool>.filled(response.data!.length, false);
    }

    return response;
  }



}