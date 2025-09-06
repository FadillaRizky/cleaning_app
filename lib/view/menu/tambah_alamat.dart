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
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Tambah Alamat"),
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
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(width: 8),
                                    index == 0
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
                                                  fontSize: 10,
                                                  color: Colors.black),
                                            ),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${snapshot.data!.data![index].picName!} (${snapshot.data!.data![index].picPhone})"),
                                    Text(
                                      snapshot.data!.data![index]
                                              .propertyAddress ??
                                          "",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      snapshot.data!.data![index].description!,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 5, 0, 5),
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
    if (!isDetail) {
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
                          height: 400,
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
                                      'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.png?key=jgR9RzmD0bqJ3JFDMu0u',
                                  additionalOptions: {
                                    'key': 'jgR9RzmD0bqJ3JFDMu0u',
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
                                              width: 40,
                                              height: 40,
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
                                    bottom: 10,
                                    right: 10,
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
                                                  style:
                                                      TextStyle(fontSize: 12),
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
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text(
                                        controller.detailLocation.value,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink();
                        }),
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
                            readOnly: isDetail),
                        FieldAlamat(
                          label: "Nomor Telepon",
                          controller: controller.phoneNumberController,
                          keyboardType: TextInputType.number,
                          readOnly: isDetail,
                        ),
                        FieldAlamat(
                          label: "Detail Alamat (Nama Jalan / No Rumah)",
                          controller: controller.detailAddressController,
                          readOnly: isDetail,
                        ),
                        Obx(() {
                          return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Type Property',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              value: controller.selectedProperty.value == ''
                                  ? null
                                  : controller.selectedProperty.value,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                              items: controller.typeProperty.map((property) {
                                return DropdownMenuItem<String>(
                                  value: property,
                                  child: Text(property),
                                );
                              }).toList(),
                              onChanged: !isDetail
                                  ? (val) =>
                                      controller.selectedProperty.value = val!
                                  : null);
                        }),
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
            child: (data != "detail-alamat")
                ? SizedBox(
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
                          "description": controller.detailAddressController.text
                        };
                        controller.storeAddress(data);
                      },
                      child: Text("Simpan"),
                    ))
                : SizedBox(
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
                  ),
          )
        ],
      ),
    );
  }

  // Future<dynamic> buildDialogLocation(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async => !controller.isLoading.value,
  //         child: Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           elevation: 0,
  //           backgroundColor: Colors.transparent,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 height: 400,
  //                 // Set the height of the map inside the dialog
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 child: FlutterMap(
  //                   mapController: controller.mapController,
  //                   options: MapOptions(
  //                     initialCenter: LatLng(-6.1754, 106.8272),
  //                     initialZoom: 13,
  //                     onTap: (tapPosition, latLng) {
  //                       controller.pickedLocation.value = latLng;
  //                       controller.latlongLocation.value =
  //                           "${latLng.latitude} , ${latLng.longitude}";
  //                       controller.latLocation.value =
  //                           latLng.latitude.toString();
  //                       controller.longLocation.value =
  //                           latLng.longitude.toString();
  //                       controller.getDetailLocation(latLng);
  //                     },
  //                   ),
  //                   children: [
  //                     TileLayer(
  //                       urlTemplate:
  //                           'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?key=b3e1d25f-8792-4ae7-a599-a93a01e9b84b',
  //                       additionalOptions: {
  //                         'key': 'b3e1d25f-8792-4ae7-a599-a93a01e9b84b',
  //                       },
  //                       userAgentPackageName: 'com.example.myapp',
  //                     ),
  //                     Obx(() {
  //                       final loc = controller.pickedLocation.value;
  //                       if (loc != null) {
  //                         // Centerkan map ke lokasi baru
  //                         Future.microtask(() {
  //                           controller.mapController
  //                               .move(loc, 15); // Zoom 15 (atau sesuaikan)
  //                         });
  //                       }

  //                       return MarkerLayer(
  //                         markers: loc != null
  //                             ? [
  //                                 Marker(
  //                                   point: loc,
  //                                   width: 40,
  //                                   height: 40,
  //                                   child: Icon(Icons.location_on,
  //                                       color: Colors.red, size: 40),
  //                                 )
  //                               ]
  //                             : [],
  //                       );
  //                     }),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 5,
  //               ),
  //               SizedBox(
  //                   width: double.infinity,
  //                   child: ElevatedButton(onPressed: () async {
  //                     controller.isLoading.value = true;

  //                     final location = Location();
  //                     final hasPermission =
  //                         await controller.checkLocationPermission(location);
  //                     if (!hasPermission) {
  //                       controller.isLoading.value = false;
  //                       return;
  //                     }

  //                     try {
  //                       final currentLocation = await location.getLocation();

  //                       if (currentLocation.latitude == null ||
  //                           currentLocation.longitude == null) {
  //                         throw Exception('Latitude or Longitude is null.');
  //                       }

  //                       final lat = currentLocation.latitude!;
  //                       final lng = currentLocation.longitude!;

  //                       final latLng = LatLng(lat, lng);
  //                       controller.pickedLocation.value = latLng;
  //                       controller.latlongLocation.value = '$lat,$lng';
  //                       controller.latLocation.value = lat.toString();
  //                       controller.longLocation.value = lng.toString();

  //                       await controller.getDetailLocation(latLng);
  //                     } catch (e) {
  //                       print('Error getting location: $e');
  //                       controller.isLoading.value = false;
  //                       return;
  //                     } finally {
  //                       controller.isLoading.value = false;
  //                     }
  //                   }, child: Obx(() {
  //                     return controller.isLoading.value
  //                         ? CircularProgressIndicator()
  //                         : Text("Gunakan lokasi saat ini");
  //                   }))),
  //               SizedBox(
  //                   width: double.infinity,
  //                   child: ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.blue,
  //                         foregroundColor: Colors.white),
  //                     onPressed: () async {
  //                       Get.back();
  //                     },
  //                     child: Text("Simpan"),
  //                   ))
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
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
        style: TextStyle(fontSize: 15, color: Colors.grey),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
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

class SelectProvince extends StatelessWidget {
  const SelectProvince({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Alamat"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
