import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/alamat.dart';
import '../../model/PropertyAddressResponse.dart';

class DaftarAlamat extends GetView<AlamatController> {
  const DaftarAlamat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alamat"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () async {
              controller.resetForm();
              var result = await Get.toNamed("/tambah-alamat");
              if (result == 'refresh') {
                controller.refreshAddress();
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 50.r,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Tambah Alamat",
                    style: TextStyle(fontSize: 38.sp, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: GetBuilder<AlamatController>(builder: (_) {
              return FutureBuilder(
                  future: controller.listAddressFuture,
                  builder: (context,
                      AsyncSnapshot<PropertyAddressResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Skeletonizer(
                          child: ListTile(
                        leading: const Icon(Icons.home),
                        title: Row(
                          children: [
                            const Text("Rumah",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Alamat Utama",
                                style: TextStyle(
                                    fontSize: 8, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        subtitle: const Text(
                            "Tangerang\nJl. Cedrawasih\nTangerang, Banten\nIndonesia"),
                        trailing: Radio<String>(
                          value: "Rumah",
                          groupValue: "selectedAddress",
                          onChanged: (value) {
                            // selectedAddress = value!;
                          },
                        ),
                        tileColor: Colors.white,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('No detail packages found.');
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.data![index];
                          return Column(
                            children: [
                              ListTile(
                                onTap: () async {
                                  controller.showDetailAddress(data);
                                  var result = await Get.toNamed(
                                      "/tambah-alamat",
                                      arguments: "detail-alamat");
                                  if (result == 'refresh') {
                                    controller.refreshAddress();
                                  }
                                },
                                title: Row(
                                  children: [
                                    Text(
                                        snapshot
                                            .data!.data![index].propertyType!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.sp)),
                                    SizedBox(width: 8),
                                    snapshot.data!.data![index].isDefault == "1"
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Text(
                                              "Utama",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30.sp),
                                            ),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data!.data![index].picName!} (${snapshot.data!.data![index].picPhone})",
                                      style: TextStyle(fontSize: 38.sp),
                                    ),
                                    Text(
                                      snapshot.data!.data![index]
                                              .propertyAddress ??
                                          "",
                                      style: TextStyle(fontSize: 36.sp),
                                    ),
                                    Text(
                                      snapshot.data!.data![index].description!,
                                      style: TextStyle(fontSize: 36.sp),
                                    ),
                                  ],
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(45.r, 15.r, 15.r, 15.r),
                                tileColor: Colors.white,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        });
                  });
            }),
          ),
        ],
      ),
    );
  }
}

class TambahAlamat extends GetView<AlamatController> {
  const TambahAlamat({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    final isDetail = data != null;
    if (isDetail) {
      var area = controller.detailLocation.value.split(',')[1].trim();
      controller.isAreaCovered.value = !controller.checkAreaCovered(area!);
    } else {
      controller.detailLocation.value =
          "Daerah khusus Ibukota Jakarta, Kota Jakarta Pusat, Kecamatan Gambir, Gambir";
      controller.specificLocation.value = "Gambir";
      controller.latlongLocation.value = "-6.1754, , 106.8272";
      controller.latLocation.value = "-6.1754";
      controller.longLocation.value = "106.8272";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Alamat"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            controller.resetForm();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 1000.h,
                          child: Stack(children: [
                            FlutterMap(
                              mapController: controller.mapController,
                              options: MapOptions(
                                  initialCenter: LatLng(-6.1754, 106.8272),
                                  initialZoom: 13,
                                  // interactionOptions: InteractionOptions(
                                  //   flags: !isDetail ? InteractiveFlag.all : InteractiveFlag.drag,
                                  // ),
                                  onTap: !isDetail
                                      ? (tapPosition, latLng) {
                                          controller.pickedLocation.value =
                                              latLng;
                                          controller.latlongLocation.value =
                                              "${latLng.latitude} , ${latLng.longitude}";
                                          controller.latLocation.value =
                                              latLng.latitude.toString();
                                          controller.longLocation.value =
                                              latLng.longitude.toString();
                                          controller.getDetailLocation(latLng);
                                        }
                                      : null),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.png?key=eRLVaXvBVHP7PY5RwKuF',
                                  additionalOptions: {
                                    'key': 'eRLVaXvBVHP7PY5RwKuF',
                                  },
                                  userAgentPackageName: 'com.example.myapp',
                                ),
                                Obx(() {
                                  final loc = controller.pickedLocation.value;
                                  if (loc != null) {
                                    // Centerkan map ke lokasi baru
                                    Future.microtask(() {
                                      controller.mapController.move(
                                          loc, 15); // Zoom 15 (atau sesuaikan)
                                    });
                                  }

                                  return MarkerLayer(
                                    markers: loc != null
                                        ? [
                                            Marker(
                                              point: loc,
                                              width: 120.w,
                                              height: 120.w,
                                              child: Icon(Icons.location_on,
                                                  color: Colors.red, size: 30),
                                            )
                                          ]
                                        : [],
                                  );
                                }),
                              ],
                            ),
                            !isDetail
                                ? Positioned(
                                    bottom: 30.w,
                                    right: 30.w,
                                    child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 35.w,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        onPressed: () async {
                                          controller.isLoading.value = true;

                                          final location = Location();
                                          final hasPermission = await controller
                                              .checkLocationPermission(
                                                  location);
                                          if (!hasPermission) {
                                            controller.isLoading.value = false;
                                            return;
                                          }

                                          try {
                                            final currentLocation =
                                                await location.getLocation();

                                            if (currentLocation.latitude ==
                                                    null ||
                                                currentLocation.longitude ==
                                                    null) {
                                              throw Exception(
                                                  'Latitude or Longitude is null.');
                                            }

                                            final lat =
                                                currentLocation.latitude!;
                                            final lng =
                                                currentLocation.longitude!;

                                            final latLng = LatLng(lat, lng);
                                            controller.pickedLocation.value =
                                                latLng;
                                            controller.latlongLocation.value =
                                                '$lat,$lng';
                                            controller.latLocation.value =
                                                lat.toString();
                                            controller.longLocation.value =
                                                lng.toString();

                                            await controller
                                                .getDetailLocation(latLng);
                                          } catch (e) {
                                            print('Error getting location: $e');
                                            controller.isLoading.value = false;
                                            return;
                                          } finally {
                                            controller.isLoading.value = false;
                                          }
                                        },
                                        icon: Icon(LineIcons.crosshairs),
                                        label: Obx(() {
                                          return controller.isLoading.value
                                              ? SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ))
                                              : Text(
                                                  "Gunakan lokasi saat ini",
                                                  style: TextStyle(
                                                      fontSize: 33.sp),
                                                );
                                        })),
                                  )
                                : SizedBox.shrink()
                          ]),
                        ),
                        Obx(() {
                          return controller.detailLocation.value != ""
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            LineIcons.mapPin,
                                            color: Colors.black,
                                          ),
                                          Text(
                                              controller.specificLocation.value,
                                              style: TextStyle(
                                                  fontSize: 43.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text(
                                        controller.detailLocation.value,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 38.sp),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink();
                        }),
                        Obx(() => controller.isAreaCovered.value
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(15)),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Maaf, layanan Utilizes belum tersedia di lokasi tersebut. Silakan ubah titik lokasi atau pilih area terdekat yang tersedia",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 38.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldAlamat(
                          label: "Nama",
                          controller: controller.nameController,
                        ),
                        FieldAlamat(
                          label: "Nomor Telepon",
                          controller: controller.phoneNumberController,
                          keyboardType: TextInputType.number,
                        ),
                        FieldAlamat(
                          label: "Detail Alamat (Nama Jalan / No Rumah)",
                          controller: controller.detailAddressController,
                        ),
                        Obx(() {
                          return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Type Property',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 40.sp),
                                border: InputBorder.none,
                              ),
                              value: controller.selectedProperty.value == ''
                                  ? null
                                  : controller.selectedProperty.value,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 40.sp),
                              items: controller.typeProperty.map((property) {
                                return DropdownMenuItem<String>(
                                  value: property,
                                  child: Text(property),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  controller.selectedProperty.value = val!);
                        }),
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jadikan Alamat Utama",
                                style: TextStyle(
                                    fontSize: 40.sp, color: Colors.black),
                              ),
                              Switch(
                                value: controller.isDefaultAddress.value,
                                activeColor: Colors.blue,
                                inactiveThumbColor: Colors.grey,
                                onChanged: (value) {
                                  controller.isDefaultAddress.value =
                                      !controller.isDefaultAddress.value;
                                },
                              ),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        if (controller.nameController.text.isEmpty) {
                          EasyLoading.showError("Nama Kosong");
                          return;
                        }
                        if (controller.phoneNumberController.text.isEmpty) {
                          EasyLoading.showError("Nomor Telepon Kosong");
                          return;
                        }
                        if (controller.detailAddressController.text.isEmpty) {
                          EasyLoading.showError("Detail Alamat Kosong");
                          return;
                        }
                        if (controller.selectedProperty.value == "") {
                          EasyLoading.showError("Type Property Kosong");
                          return;
                        }
                        if (controller.latlongLocation.value.isEmpty) {
                          EasyLoading.showError("Silahkan Pilih Titik Lokasi");
                          return;
                        }

                        var data = {
                          "pic_name": controller.nameController.text,
                          "pic_phone": controller.phoneNumberController.text,
                          "property_type": controller.selectedProperty.value,
                          "lat": controller.latLocation.value,
                          "long": controller.longLocation.value,
                          "property_address": controller.detailLocation.value,
                          "description":
                              controller.detailAddressController.text,
                          "is_default":
                              controller.isDefaultAddress.value ? "1" : "0"
                        };
                        if (isDetail) {
                          data["id"] = controller.idAddress.value;
                        }
                        controller.fetchAddress(data, isDetail);
                      },
                      child: Text("Simpan"),
                    )),
                (isDetail)
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              var data = {"id": controller.idAddress.value};
                              controller.deleteAddress(data);
                            },
                            child: Text("Hapus Alamat")),
                      )
                    : SizedBox.shrink()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FieldAlamat extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final int? maxlines;

  const FieldAlamat({
    super.key,
    required this.label,
    this.onTap,
    required this.controller,
    this.keyboardType,
    this.readOnly,
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    var isProvince = label == "Provinsi, Kota, Kecamatan";
    var isCurrentLocation = label == "Pilih Lokasi";
    return GestureDetector(
      onTap: isProvince || isCurrentLocation ? onTap : null,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        maxLines: maxlines,
        style: TextStyle(fontSize: 40.sp, color: Colors.grey),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 40.sp, color: Colors.black),
          suffixIcon: isCurrentLocation ? Icon(Icons.arrow_forward_ios) : null,
          border: InputBorder.none,
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabled: isProvince || isCurrentLocation ? false : true,
        ),
      ),
    );
  }
}
