import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/ListPackageResponse.dart';
import 'package:cleaning_app/model/ObjectPackageResponse.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:get/get.dart';

import '../api.dart';

class PackageController extends GetxController {
  var category = "".obs;

  ///Carousel detail Category
  var currentIndex = 0.obs;

  RxList<bool> selectPackageDeep = <bool>[].obs;
  RxList<bool> selectObjectPackage = <bool>[].obs;
  RxList<int> amountObjectPackage = <int>[].obs;

  RxList<Map<String, dynamic>> tempDataObject = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> resultDataObject = <Map<String, dynamic>>[].obs;

  ///Daily Cleaning Section
  var selectedPackageId = ''.obs;
  var selectedPackageImg = ''.obs;
  var selectedPackageName = ''.obs;

  var selectedPhId = ''.obs;
  var selectedDiscountPrice = ''.obs;
  var selectedRealPrice = ''.obs;
  var selectedDuration = ''.obs;

  void resetSelection() {
    selectedPhId.value = '';
    selectedDuration.value = '';
    selectedRealPrice.value = '';
    selectedDiscountPrice.value = '';
  }

  Future<Map<String, dynamic>> getDetailPackage(String id) async {
    final dataDetail = await Api.getDetailPackage(id);
    final dataDuration = await Api.getDurationPackage(id);
    // final dataProperty = await Api.getAddress();
    return {
      'data_detail': dataDetail,
      'data_duration': dataDuration,
    };
  }

  /// Deep Cleaning Section
  String amountObjectPrice() {
    var amount = tempDataObject.fold(0, (sum, item) {
      final price = item["object_price"] as int;
      final qty = item["object_amount"] as int;
      return sum + (price * qty);
    });

    return Utils.formatCurrency(amount);
  }

  int amountObjectQty() {
    var total = tempDataObject.fold(0, (sum, item) {
      return sum + (item["object_amount"] as int);
    });

    return total;
  }

  amountItemperPackage(num id) {
    final matchedPack = resultDataObject.firstWhere(
      (element) => element["pack_id"] == id,
      orElse: () => {},
    );
    print("result : $resultDataObject");

    if (matchedPack.isNotEmpty && matchedPack["data_object"] is List) {
      //     var total = tempDataObject.fold(0, (sum, item) {
      //   return sum + (item["object_amount"] as int);
      // });
      return matchedPack["data_object"].fold(0, (sum, item) {
        return sum + (item["object_amount"] as int);
      });
    } else {
      return 0;
    }
  }

  amountPriceperPackage(num id) {
    final matchedPack = resultDataObject.firstWhere(
      (element) => element["pack_id"] == id,
      orElse: () => {},
    );
    // print(matchedPack);

    if (matchedPack.isNotEmpty && matchedPack["data_object"] is List) {
      return matchedPack["data_object"].fold(0, (total, item) {
        final price = int.tryParse(item['object_price'].toString()) ?? 0;
        final qty = int.tryParse(item['object_amount'].toString()) ?? 0;
        return total + (price * qty);
      });
    } else {
      return 0;
    }
  }

  Future<ObjectPackageResponse> getObjectPackage(String pack_id) async {
    final response = await Api.getObjectPackage(pack_id);

    final existingPack = resultDataObject.firstWhere(
      (element) => element["pack_id"].toString() == pack_id,
      orElse: () => {},
    );

    List<bool> tempSelect = [];
    List<int> tempAmount = [];

    if (existingPack.isNotEmpty) {
      // Ambil daftar object_id dari data_object di resultDataObject
      final existingObjectList = (existingPack["data_object"] as List);

      final existingObjectIds =
          existingObjectList.map((e) => e["object_id"]).toList();

      // Buat list bool dan amount berdasarkan data existing
      tempSelect = response.data!
          .map((e) => existingObjectIds.contains(e.objectId))
          .toList();

      // Generate jumlah berdasarkan data existing, default 0 jika belum ada
      tempAmount = response.data!.map((e) {
        final found = existingObjectList.firstWhere(
          (obj) => obj["object_id"] == e.objectId,
          orElse: () => {"object_amount": 1},
        );
        return (found["object_amount"] ?? 1) as int;
      }).toList();

      tempDataObject.addAll(existingPack["data_object"]);
    } else {
      // Jika tidak ada data sebelumnya
      tempSelect = List<bool>.filled(response.data!.length, false);
      tempAmount = List<int>.filled(response.data!.length, 1);
    }

    // Set nilai observables
    selectObjectPackage.value = tempSelect;
    amountObjectPackage.value = tempAmount;

    return response;
  }

  void updateObjectAmount(int objectId, int newAmount) {
    final index = tempDataObject.indexWhere(
      (element) => element["object_id"] == objectId,
    );

    if (index != -1) {
      // Update value
      tempDataObject[index]["object_amount"] = newAmount;

      // Trigger update agar UI reactive (karena Map tidak otomatis terdeteksi)
      tempDataObject.refresh();
    }
  }

  void addResultDataObject(int packId, String packName, String packImg,
      double packDisc, List<Map<String, dynamic>> newDataObject) {
    final index =
        resultDataObject.indexWhere((element) => element["pack_id"] == packId);

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
        "pack_disc": packDisc,
        "data_object": newDataObject
      });
    }
    print("sumarry : $resultDataObject");
  }

  /// Common Section
  Future<ListPackageResponse> getlistPackage(String category) async {
    final response = await Api.getPackageList(category);

    if (category != "Daily Cleaning" && response.data != null) {
      selectPackageDeep.value = List<bool>.filled(response.data!.length, false);
    }

    return response;
  }
}
