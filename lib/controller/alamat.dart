import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as loc;

import '../api.dart';
import '../model/PropertyAddressResponse.dart';

class AlamatController extends GetxController {
  late Future<PropertyAddressResponse> listAddressFuture;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController detailAddressController;
  // late TextEditingController typePropertyController;
  var typeProperty = ['Rumah', 'Apartement', 'Kontrakan', 'Kos'].obs;
  var selectedProperty = "".obs;
  var detailLocation = "".obs;
  var specificLocation = "".obs;
  var latlongLocation = "".obs;
  var latLocation = "".obs;
  var longLocation = "".obs;
  var idAddress = "".obs;

  var isLoading = false.obs;
  final mapController = MapController();
  var pickedLocation = Rxn<LatLng>(
    LatLng(-6.1754, 106.8272), // Pusat Jakarta
  );

  // Future<PropertyAddressResponse> getDetailPackage() {
  //   return Api.getAddress();
  // }
  void refreshAddress() {
    listAddressFuture = Api.getAddress();
    update(); // for GetBuilder
  }

  resetForm() {
    nameController.clear();
    phoneNumberController.clear();
    detailAddressController.clear();
    selectedProperty.value == "";
    detailLocation.value = "";
    specificLocation.value = "";
    latlongLocation.value = "";
    latLocation.value = "";
    longLocation.value = "";
    pickedLocation.value = LatLng(-6.1754, 106.8272);
  }

    Future<bool> checkLocationPermission(loc.Location location) async {
      bool serviceEnabled = await location.serviceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();

        await Future.delayed(Duration(seconds: 1));
        serviceEnabled = await location.serviceEnabled();

        if (!serviceEnabled) {
          return false;
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          return false;
        }
      }

      return true;
    }

    getDetailLocation(LatLng latLng) async {
      try {
        List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          latLng.latitude,
          latLng.longitude,
        );

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final provinsi = place.administrativeArea; // Provinsi
          final kabupaten = place.subAdministrativeArea; // Kabupaten / Kota
          final kecamatan = place.locality ?? place.subLocality; // Kecamatan
          final kelurahan = place.subLocality ?? place.name; // Kelurahan/Desa fallback ke name

          detailLocation.value = "$provinsi, $kabupaten, $kecamatan, $kelurahan";
          specificLocation.value = kelurahan!;
        }
      } catch (e) {
        print('Error: $e');
      }
    }

  Future<void> storeAddress(Map<String, dynamic> data) async {
    try {
      EasyLoading.show();
      var response = await Api.storeAddress(data);
      if (response.status == true) {
        Get.back(result: 'refresh');
        EasyLoading.showSuccess("Berhasil Menambahkan Alamat");
        resetForm();
      } else {
        EasyLoading.showError("Gagal kirim data");
      }
    } catch (e, stackTrace) {
      print("Error: $e");
      print("StackTrace: $stackTrace");
      EasyLoading.showError("Gagal kirim data: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> deleteAddress(Map<String, dynamic> data) async {
    try {
      EasyLoading.show();
      var response = await Api.deleteAddress(data);
      if (response.status == true) {
        Get.back(result: 'refresh');
        EasyLoading.showSuccess("Berhasil Menghapus Alamat");
        resetForm();
        if (response.status == false &&
            response.message == "data not found /has been deleted") {
          EasyLoading.showError("Alamat Sudah Terhapus");
          EasyLoading.showSuccess("Berhasil Menghapus Alamat");
          resetForm();
        }
      } else {
        EasyLoading.showError("Gagal Hapus data");
      }
    } catch (e, stackTrace) {
      print("Error: $e");
      print("StackTrace: $stackTrace");
      EasyLoading.showError("Gagal kirim data: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  showDetailAddress(Data data) {
    nameController.text = data.picName!;
    phoneNumberController.text = data.picPhone!;
    detailLocation.value = data.propertyAddress!;
    List<String> parts = data.propertyAddress!.split(',');
    String kelurahan = parts.last;
    specificLocation.value = kelurahan;
    detailAddressController.text = data.description!;
    selectedProperty.value = data.propertyType!;
    latlongLocation.value = "${data.lat},${data.long}";
    latLocation.value = data.lat ?? "";
    longLocation.value = data.long ?? "";
    double lat = double.parse(data.lat ?? "0");
    double lng = double.parse(data.long ?? "0");
    pickedLocation.value = LatLng(lat, lng);
    idAddress.value = data.id.toString();
  }

  @override
  void onInit() {
    super.onInit();
    print("refresh");
    refreshAddress();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    detailAddressController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    detailAddressController.dispose();
    super.onClose();
  }
}
