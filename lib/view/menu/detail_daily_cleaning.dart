import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/detail_daily_cleaning.dart';
import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/DurationPackageResponse.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widget/utils.dart';

class DetailDailyCleaning extends GetView<PackageController> {
  final String id;
  final String title;

  const DetailDailyCleaning({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: FutureBuilder(
          future: controller.getDetailPackage(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Skeletonizer(
                  child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Text("Daily Cleaning"),
                        Text(
                            "Layanan kebersihan rutin yang dilakukan setiap hari untuk menjaga kebersihan dan kerapian sebuah hunian. Tujuannya adalah untuk mencegah penumpukan kotoran, debu, dan sampah, serta menciptakan lingkungan yang bersih, sehat, dan nyaman."),
                      ],
                    ),
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No detail packages found.');
            }
            final detail =
                snapshot.data!['data_detail'] as DetailPackageResponse;
            final duration =
                snapshot.data!['data_duration'] as DurationPackageResponse;
            // final property =
            //     snapshot.data!['data_property'] as PropertyAddressResponse;
            return detailPackage(detail, duration, context);
          }),
    );
  }

  Widget detailPackage(
      DetailPackageResponse detail,
      DurationPackageResponse duration,
      // PropertyAddressResponse property,
      BuildContext context) {
    // controller.picName.value = property.data!.first.picName!;
    // controller.propertyAddress.value = property.data!.first.propertyAddress!;
    // controller.selectedProperty.value = property.data!.first.id!.toInt();
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: detail.data!.pack!.packBannerPath ?? "",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      Center(child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.data!.pack!.packName!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ReadMoreText(
                        detail.data!.pack!.packObjectDescription!,
                        trimLines: 10,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: 'Read less',
                        style: TextStyle(fontSize: 15),
                        moreStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                        lessStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   "Pilih Alamat",
                      //   style: TextStyle(
                      //       fontSize: 17, fontWeight: FontWeight.bold),
                      // ),
                      // Obx(() {
                      //   return ListTile(
                      //     contentPadding: EdgeInsets.only(left: 5, right: 0),
                      //     leading: Icon(Icons.home),
                      //     title: Text(
                      //       controller.picName.value,
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //     subtitle: Text(
                      //       controller.propertyAddress.value,
                      //       style: TextStyle(fontSize: 13),
                      //     ),
                      //     trailing: TextButton(
                      //       style: ButtonStyle(
                      //         overlayColor:
                      //             MaterialStateProperty.all(Colors.transparent),
                      //       ),
                      //       onPressed: () {
                      //         showDialog(
                      //           context: context,
                      //           builder: (BuildContext context) {
                      //             return Dialog(
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(
                      //                     10.0), // Sudut membulat
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(15),
                      //                 child: Column(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: [
                      //                     // Title for the dialog
                      //                     Row(
                      //                       children: [
                      //                         Text(
                      //                           'Pilih Alamat',
                      //                           style: TextStyle(fontSize: 18),
                      //                         ),
                      //                       ],
                      //                     ),
                      //
                      //                     SizedBox(height: 10),
                      //
                      //                     // ListView.builder for displaying the addresses
                      //                     SizedBox(
                      //                       height: 200,
                      //                       // Set the height of the list view
                      //                       child: ListView.builder(
                      //                         itemCount: property.data!.length,
                      //                         itemBuilder: (context, index) {
                      //                           return Obx(() {
                      //                             return ListTile(
                      //                               contentPadding:
                      //                                   EdgeInsets.only(
                      //                                       left: 5, right: 0),
                      //                               leading: Icon(Icons.home),
                      //                               title: Text(
                      //                                 property.data![index]
                      //                                     .picName!,
                      //                                 style: TextStyle(
                      //                                     fontSize: 13),
                      //                               ),
                      //                               subtitle: Text(
                      //                                 property.data![index]
                      //                                     .propertyAddress!,
                      //                                 style: TextStyle(
                      //                                     fontSize: 12),
                      //                               ),
                      //                               trailing: Radio(
                      //                                   value: property
                      //                                       .data![index].id,
                      //                                   groupValue: controller
                      //                                       .selectedProperty
                      //                                       .value,
                      //                                   onChanged: (value) {
                      //                                     controller
                      //                                             .selectedProperty
                      //                                             .value =
                      //                                         value!.toInt();
                      //                                     controller.picName
                      //                                             .value =
                      //                                         property
                      //                                             .data![index]
                      //                                             .picName!;
                      //                                     controller
                      //                                             .propertyAddress
                      //                                             .value =
                      //                                         property
                      //                                             .data![index]
                      //                                             .propertyAddress!;
                      //                                   }),
                      //                             );
                      //                           });
                      //                         },
                      //                       ),
                      //                     ),
                      //
                      //                     // Button to close the dialog
                      //                     SizedBox(height: 20),
                      //                     SizedBox(
                      //                         width: double.infinity,
                      //                         child: ElevatedButton(
                      //                             style: ElevatedButton.styleFrom(
                      //                                 backgroundColor:
                      //                                     Colors.blue,
                      //                                 foregroundColor:
                      //                                     Colors.white,
                      //                                 shape:
                      //                                     RoundedRectangleBorder(
                      //                                         borderRadius:
                      //                                             BorderRadius
                      //                                                 .circular(
                      //                                                     10))),
                      //                             onPressed: () {
                      //                               Navigator.pop(context);
                      //                             },
                      //                             child: Text("Simpan")))
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       },
                      //       child: Text("Ubah"),
                      //     ),
                      //   );
                      // }),
                      Divider(),
                      Text(
                        "Durasi Pengerjaan",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: duration.data!.length,
                        itemBuilder: (context, index) {
                          // print("duration.data!.length");/
                          // print(duration.data!.length);
                          return selectDuration(
                            controller: controller,
                            title: duration.data![index].packHour!.toInt(),
                            normalPrice:
                                duration.data![index].packPrice!.toInt(),
                            realPrice:
                                duration.data![index].packPriceDisc!.toInt(),
                          );
                        },
                      ),
                      Divider(),
                      // Text(
                      //   "Pilih Waktu Layanan",
                      //   style: TextStyle(
                      //       fontSize: 17, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   "Tanggal",
                      //   style: TextStyle(fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // TextField(
                      //   controller: controller.dateController,
                      //   decoration: InputDecoration(
                      //     hintText: "Pilih Tanggal",
                      //     hintStyle: TextStyle(
                      //       color: Colors.grey,
                      //     ),
                      //     suffixIcon: Icon(
                      //       Icons.calendar_month_rounded,
                      //       color: Colors.grey,
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.grey, width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey.shade300),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     disabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey.shade300),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     filled: true,
                      //     fillColor: Color(0xfff7f9fc),
                      //   ),
                      //   readOnly: true,
                      //   onTap: () {
                      //     controller.selectDate(context);
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   "Waktu",
                      //   style: TextStyle(fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // TextField(
                      //   controller: controller.timeController,
                      //   decoration: InputDecoration(
                      //     hintText: "Pilih Waktu",
                      //     hintStyle: TextStyle(
                      //       color: Colors.grey,
                      //     ),
                      //     suffixIcon: Icon(
                      //       Icons.access_time_outlined,
                      //       color: Colors.grey,
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.grey, width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey.shade300),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     disabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey.shade300),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     filled: true,
                      //     fillColor: Color(0xfff7f9fc),
                      //   ),
                      //   readOnly: true,
                      //   onTap: () {
                      //     // controller.selectTime(context);
                      //     Navigator.push(
                      //         context,
                      //         showPicker(
                      //           context: context,
                      //           value: Time(hour: 11, minute: 30, second: 20),
                      //           sunrise: TimeOfDay(hour: 6, minute: 0),
                      //           // optional
                      //           sunset: TimeOfDay(hour: 18, minute: 0),
                      //           // optional
                      //           is24HrFormat: true,
                      //           duskSpanInMinutes: 120,
                      //           // optional
                      //           minHour: 8,
                      //           maxHour: 18,
                      //           onChange: (time) {
                      //             String formattedTime =
                      //                 '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                      //             controller.timeController.text =
                      //                 formattedTime;
                      //           },
                      //         ));
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Divider(),
                      Text(
                        "Informasi Layanan",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          cardLayanan(
                            path: '././assets/icon/estimasi_pengerjaan.svg',
                            title: 'Estimasi Pengerjaan',
                            description:
                                detail.data!.pack!.packProcedureDescription!,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          cardLayanan(
                            path: '././assets/icon/detail_pengerjaan.svg',
                            title: 'Detail Pengerjaan',
                            description: detail.data!.pack!.packJobDescription!,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          cardLayanan(
                            path: '././assets/icon/peralatan.svg',
                            title: 'Peralatan',
                            description:
                                detail.data!.pack!.packObjectDescription!,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Color(0xfff4f4f4),
            ),
            child: Obx(() {
              return Column(
                children: [
                  controller.selectedPriceDuration.value != ""
                      ? Column(
                          children: [
                            Obx(() {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Pesanan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                      "Rp ${controller.selectedDiscount.value}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Biaya Layanan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                                Text("Rp 2.000",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                                Text(
                                    Utils.formatCurrency(int.parse(
                                            controller.selectedPriceDuration.value) -
                                        int.parse(
                                            controller.selectedDiscount.value)),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    Utils.formatCurrency(int.parse(
                                            controller.selectedPriceDuration.value) +
                                        2000),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.selectedPriceDuration.value != ""
                            ? Colors.blue
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide.none,
                        ),
                      ),
                      onPressed: controller.selectedPriceDuration.value != ""
                          ? () {
                        controller.selectedPackageName.value = detail.data!.pack!.packName!;
                        controller.selectedPackageImg.value = detail.data!.pack!.packBannerPath ?? "";
                        Get.toNamed("/pemesanan");
                            }
                          : null,
                      child: Text(
                        "Lanjutkan",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }))
      ],
    );
  }

  static DetailDailyCleaning fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return DetailDailyCleaning(
      id: args['id'],
      title: args['title'],
    );
  }
}

class cardLayanan extends StatelessWidget {
  final String path;
  final String title;
  final String description;

  const cardLayanan({
    super.key,
    required this.path,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Sudut membulat
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(title,maxLines: 2,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Icon(Icons.close,color: Colors.black,))
                        ],),
                        Divider(),
                        Expanded(
                            child:
                                SingleChildScrollView(child: Text(description)))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  path,
                  fit: BoxFit.contain,
                  height: 40,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class selectDuration extends StatelessWidget {
  final int title;
  final int normalPrice;
  final int realPrice;

  const selectDuration({
    super.key,
    required this.controller,
    required this.title,
    required this.normalPrice,
    required this.realPrice,
  });

  final PackageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            "$title Jam",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          secondary: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Utils.formatCurrency(normalPrice).toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 8),
              Text(Utils.formatCurrency(realPrice).toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          value: realPrice.toString(),
          groupValue: controller.selectedPriceDuration.value,
          onChanged: (value) {
            controller.selectedPriceDuration.value = value!;
            controller.selectedDiscount.value = normalPrice.toString();
            controller.selectedDuration.value = title.toString();
          });
    });
  }
}
