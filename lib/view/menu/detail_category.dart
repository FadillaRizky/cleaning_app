import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/model/ListPackageResponse.dart' as Data;
import 'package:cleaning_app/model/ObjectPackageResponse.dart';
import 'package:cleaning_app/widget/count_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/package.dart';
import '../../widget/cached_image.dart';
import '../../widget/card_package.dart';
import '../../widget/utils.dart';

class DetailCategory extends GetView<PackageController> {
  final String id;
  final String title;
  final List img_url;
  final String description;

  DetailCategory({
    super.key,
    required this.title,
    required this.id,
    required this.img_url,
    required this.description,
  });
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: img_url.length,
                        itemBuilder: (context, index, realIndex) {
                          return CachedImage(
                              imgUrl: img_url[index],
                              height: 200,
                              width: double.infinity);
                        },
                        options: CarouselOptions(
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            controller.currentIndex.value = index;
                          },
                        ),
                      ),
                      Obx(() {
                        return Positioned(
                          bottom: 10, // beri jarak dari bawah
                          left: 0,
                          right: 0,
                          child: Container(
                            child: Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: controller.currentIndex.value,
                                count: img_url.length,
                                effect: const WormEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    activeDotColor: Colors.orange,
                                    dotColor: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        profileController.hasVoucher.value != false
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      LineIcons.alternateTicket,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Voucher Member",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red.shade400,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 8,
                        ),
                        ReadMoreText(
                          description,
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
                        title != "Daily Cleaning"
                            ? Column(
                                children: [
                                  Text(
                                    "Pilihan Paket",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
                        FutureBuilder(
                            future: (controller.getlistPackage(title)),
                            builder: (context,
                                AsyncSnapshot<Data.ListPackageResponse>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Skeletonizer(
                                    child: Column(
                                  children: [
                                    DailyCleaningCard(
                                      imgPath: '././assets/intro1.png',
                                      title: "Jasa Borongan Cleaning",
                                      subtitle:
                                          "Tersedia pilihan jasa cleaning berdasarkan luas area, jumlah tenaga kerja, waktu pengerjaan atau jenis acara/kegiatan.",
                                      discPercent: null,
                                      ontap: () {},
                                    ),
                                  ],
                                ));
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData) {
                                return const Text('No list packages found.');
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (context, index) {
                                  if (title != "Daily Cleaning") {
                                    var data = snapshot.data!.data![index];
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // controller
                                            //         .selectPackageDeep[index] =
                                            //     !controller
                                            //         .selectPackageDeep[index];
                                            // if (controller
                                            //     .selectPackageDeep[index]) {
                                            //   popupObjectPackage(context, data,
                                            //       () {
                                            //     controller.selectPackageDeep[
                                            //         index] = false;
                                            //   }, "tambah");
                                            // } else {
                                            //   controller.resultDataObject
                                            //       .removeWhere((element) =>
                                            //           element["pack_id"] ==
                                            //           data.packId);
                                            // }
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 10, 10, 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Obx(() {
                                                    return Checkbox(
                                                        value: controller
                                                                .selectPackageDeep[
                                                            index],
                                                        activeColor:
                                                            Colors.blue,
                                                        side: BorderSide(
                                                            color: Colors
                                                                .grey[500]!),
                                                        onChanged:
                                                            (bool? value) {
                                                          controller
                                                                  .selectPackageDeep[
                                                              index] = value!;
                                                          if (controller
                                                                  .selectPackageDeep[
                                                              index]) {
                                                            popupObjectPackage(
                                                                context, data,
                                                                () {
                                                              controller
                                                                      .selectPackageDeep[
                                                                  index] = false;
                                                            }, "tambah");
                                                          } else {
                                                            controller
                                                                .resultDataObject
                                                                .removeWhere(
                                                                    (element) =>
                                                                        element[
                                                                            "pack_id"] ==
                                                                        data.packId);
                                                          }
                                                        });
                                                  }),
                                                  Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: CachedImage(
                                                          imgUrl:
                                                              data.packBannerPath ??
                                                                  "",
                                                          height: 70,
                                                          width: 70,
                                                        ),
                                                      ),
                                                      if (data.discPercentage !=
                                                          null) // ✅ tambahkan flag promo dari model kamu
                                                        Positioned(
                                                          top: 4,
                                                          left: 4,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        2),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .redAccent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            child: const Text(
                                                              "PROMO",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 14,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              data.packName! ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            (data.packCategory != "Daily Cleaning" )
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      Get.toNamed(
                                                                          "/package_description",
                                                                          arguments: {
                                                                            'globalDesc':
                                                                                data.packGlobalDescription
                                                                          });
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .info,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 15,
                                                                    ))
                                                                : SizedBox
                                                                    .shrink()
                                                          ],
                                                        ),
                                                        Obx(() {
                                                          final count = controller
                                                              .amountItemperPackage(
                                                                  data.packId!);
                                                          // print("count ${data.packId}: $count");
                                                          return count > 0
                                                              ? Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            "$count Item"),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              25,
                                                                          child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: Colors.blue, foregroundColor: Colors.white, textStyle: TextStyle(fontSize: 12)),
                                                                              onPressed: () {
                                                                                popupObjectPackage(context, data, () {
                                                                                  controller.selectPackageDeep[index] = false;
                                                                                }, "edit");
                                                                              },
                                                                              child: Text("Detail")),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Spacer(),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          "Total Harga",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          Utils.formatCurrency(
                                                                              controller.amountPriceperPackage(data.packId!)),
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              : SizedBox
                                                                  .shrink();
                                                          // : Text(
                                                          //     "(ketuk untuk memilih paket)",
                                                          //     style: TextStyle(
                                                          //         fontStyle:
                                                          //             FontStyle
                                                          //                 .italic,
                                                          //         color: Colors
                                                          //                 .grey[
                                                          //             500]!),
                                                          //   );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  } else {
                                    return DailyCleaningCard(
                                      imgPath: snapshot.data!.data![index]
                                              .packBannerPath ??
                                          "",
                                      title: snapshot
                                              .data!.data![index].packName ??
                                          "-",
                                      subtitle: snapshot.data!.data![index]
                                          .packGlobalDescription!,
                                      discPercent: snapshot.data!.data![index]
                                              .discPercentage ??
                                          0.0,
                                      ontap: () {
                                        print(
                                            controller.selectedPackageId.value);
                                        controller.category.value = title;
                                        controller.selectedPackageId.value =
                                            snapshot.data!.data![index].packId!
                                                .toString();
                                        Get.toNamed(
                                          '/detail-daily',
                                          arguments: {
                                            'id': snapshot
                                                .data!.data![index].packId!
                                                .toString(),
                                            'title': snapshot
                                                .data!.data![index].packName!,
                                            'discPercent': snapshot
                                                .data!
                                                .data![index]
                                                .discPercentage, // biarkan null
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          title != "Daily Cleaning"
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f4f4),
                    // color: Colors.transparent,
                  ),
                  child: Obx(() {
                    int normalTotal = 0;
                    int total = 0;
                    int qty = 0;
                    for (var pack in controller.resultDataObject) {
                      final objects = pack["data_object"] as List;

                      for (var obj in objects) {
                        final price = obj["object_price"] as int;
                        final normalPrice = obj["object_normal_price"] as int;
                        final amount = obj["object_amount"] as int;

                        total += price * amount;
                        normalTotal += normalPrice * amount;
                        qty += amount;
                      }
                    }
                    bool hasDiscount = controller.resultDataObject
                        .any((pack) => pack["pack_disc"] != 0);
                    return Column(
                      children: [
                        controller.resultDataObject.isNotEmpty
                            ? Column(
                                children: [
                                  (profileController.hasVoucher.value ||
                                          hasDiscount)
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Subtotal",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                    Utils.formatCurrency(
                                                        normalTotal),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${profileController.hasVoucher.value ? "Voucher Member" : ""}"
                                                  "${profileController.hasVoucher.value && hasDiscount ? " + " : ""}"
                                                  "${hasDiscount ? "Promo" : ""}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                    "- ${Utils.formatCurrency(normalTotal - total)}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(Utils.formatCurrency(total),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Qty",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text("$qty Item",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Biaya Layanan",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.w600,
                                  //           color: Colors.grey),
                                  //     ),
                                  //     Text("Rp 2.000",
                                  //         style: TextStyle(
                                  //             fontSize: 14,
                                  //             fontWeight: FontWeight.bold)),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Discount",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.w600,
                                  //           color: Colors.grey),
                                  //     ),
                                  //     Text(
                                  //         Utils.formatCurrency(int.parse(
                                  //             controller.selectedDuration.value) -
                                  //             int.parse(
                                  //                 controller.selectedDiscount.value)),
                                  //         style: TextStyle(
                                  //             fontSize: 14,
                                  //             fontWeight: FontWeight.bold,
                                  //             color: Colors.red)),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Total",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.w600),
                                  //     ),
                                  //     Text(Utils.formatCurrency(total + 2000),
                                  //         style: TextStyle(
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.bold)),
                                  //   ],
                                  // ),
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
                              backgroundColor:
                                  controller.resultDataObject.isNotEmpty
                                      ? Colors.blue
                                      : Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none,
                              ),
                            ),
                            onPressed: controller.resultDataObject.isNotEmpty
                                ? () {
                                    print(
                                        "result = ${controller.resultDataObject}");
                                    controller.category.value = title;
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
              : SizedBox.shrink()
        ],
      ),
    );
  }

  Future<dynamic> popupObjectPackage(
    BuildContext context,
    Data.Data data,
    VoidCallback onClose,
    String action,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 500,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.packName!,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                            onTap: () {
                              controller.tempDataObject.clear();
                              Get.back();

                              if (action == "edit") {
                                if (!controller.selectObjectPackage
                                    .any((e) => e)) {
                                  controller.resultDataObject.removeWhere(
                                    (element) =>
                                        element["pack_id"] == data.packId,
                                  );
                                  onClose();
                                }
                              } else {
                                onClose();
                              }
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                      child: FutureBuilder(
                          future: controller
                              .getObjectPackage(data.packId.toString()),
                          builder: (context,
                              AsyncSnapshot<ObjectPackageResponse> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Skeletonizer(
                                  child: Text(
                                      "asdkjhkjhhkdajshkdjhsakdjhaskdjhaksjdh"));
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData) {
                              return const Text('No list packages found.');
                            }
                            final options = snapshot.data!.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectObjectPackage[index] =
                                            !controller
                                                .selectObjectPackage[index];
                                        if (controller
                                            .selectObjectPackage[index]) {
                                          controller.tempDataObject.add({
                                            "object_id":
                                                options[index].objectId,
                                            "object_name":
                                                options[index].objectName,
                                            "object_normal_price":
                                                options[index].objectPrice,
                                            "object_price":
                                                options[index].objectPriceDisc,
                                            "object_amount": controller
                                                .amountObjectPackage[index],
                                          });
                                        } else {
                                          controller.tempDataObject.removeWhere(
                                              (item) =>
                                                  item['object_id'] ==
                                                  options[index].objectId);
                                        }
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(() {
                                            return Checkbox(
                                              value: controller
                                                  .selectObjectPackage[index],
                                              onChanged: (bool? value) {
                                                controller.selectObjectPackage[
                                                    index] = value!;
                                                if (controller
                                                        .selectObjectPackage[
                                                    index]) {
                                                  controller.tempDataObject
                                                      .add({
                                                    "object_id":
                                                        options[index].objectId,
                                                    "object_name":
                                                        options[index]
                                                            .objectName,
                                                    "object_normal_price":
                                                        options[index]
                                                            .objectPrice,
                                                    "object_price":
                                                        options[index]
                                                            .objectPriceDisc,
                                                    "object_amount": controller
                                                            .amountObjectPackage[
                                                        index],
                                                  });
                                                } else {
                                                  controller.tempDataObject
                                                      .removeWhere((item) =>
                                                          item['object_id'] ==
                                                          options[index]
                                                              .objectId);
                                                }
                                              },
                                            );
                                          }),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  options[index].objectName ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  options[index]
                                                          .objectDescription ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              (options[index].objectPriceDisc !=
                                                      options[index]
                                                          .objectPrice)
                                                  ? Column(
                                                      children: [
                                                        Text(Utils.formatCurrency(
                                                            options[index]
                                                                .objectPriceDisc!)),
                                                        Text(
                                                            Utils.formatCurrency(
                                                                options[index]
                                                                    .objectPrice!),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            )),
                                                      ],
                                                    )
                                                  : Text(
                                                      Utils.formatCurrency(
                                                          options[index]
                                                              .objectPrice!),
                                                    ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Obx(() {
                                                return controller
                                                            .selectObjectPackage[
                                                        index]
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (controller
                                                                          .amountObjectPackage[
                                                                      index] !=
                                                                  1) {
                                                                controller
                                                                        .amountObjectPackage[
                                                                    index]--;
                                                                controller.updateObjectAmount(
                                                                    options[index]
                                                                        .objectId!
                                                                        .toInt(),
                                                                    controller
                                                                            .amountObjectPackage[
                                                                        index]);
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .surface,
                                                            ),
                                                            child: Text(
                                                                controller
                                                                    .amountObjectPackage[
                                                                        index]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12)),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          InkWell(
                                                            onTap: () {
                                                              controller
                                                                      .amountObjectPackage[
                                                                  index]++;
                                                              controller.updateObjectAmount(
                                                                  options[index]
                                                                      .objectId!
                                                                      .toInt(),
                                                                  controller
                                                                          .amountObjectPackage[
                                                                      index]);
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox.shrink();
                                              })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      indent: 10,
                                    )
                                  ],
                                );
                              },
                            );
                          }),
                    ),
                  )),
                  Obx(() {
                    return controller.selectObjectPackage.any((e) => e)
                        ? Container(
                            padding: EdgeInsets.all(10),
                            child: Obx(() {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Item"),
                                      Text(controller
                                          .amountObjectQty()
                                          .toString()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Harga"),
                                      Text(controller.amountObjectPrice()),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white),
                                        onPressed: () {
                                          // print(
                                          //     "hasil : ${controller.tempDataObject}");
                                          controller.addResultDataObject(
                                            data.packId!.toInt(),
                                            data.packName ?? "",
                                            data.packBannerPath ?? "",
                                            (data.discPercentage as num?)
                                                    ?.toDouble() ??
                                                0.0, // ✅ aman untuk int, double, null
                                            controller.tempDataObject.toList(),
                                          );
                                          controller.tempDataObject.clear();

                                          Get.back();
                                        },
                                        child: Text("Simpan")),
                                  )
                                ],
                              );
                            }),
                          )
                        : SizedBox.shrink();
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static DetailCategory fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return DetailCategory(
      id: args['id'],
      title: args['title'],
      img_url: args['img_url'],
      description: args['description'],
    );
  }
}
