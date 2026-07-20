import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/model/ListPackageResponse.dart' as Data;
import 'package:cleaning_app/model/ObjectPackageResponse.dart';
import 'package:cleaning_app/widget/count_number.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
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
                            bottom: 30.h, // beri jarak dari bawah
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
                      padding: EdgeInsets.all(43.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 60.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          profileController.hasVoucher.value != false
                              ? Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red.shade300,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            LineIcons.alternateTicket,
                                            color: Colors.red,
                                            size: 35.r,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Voucher Member",
                                            style: TextStyle(
                                              fontSize: 25.sp,
                                              color: Colors.red.shade400,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        bottom: -1,
                                        right: -1,
                                        child: Icon(
                                          Icons.check_circle,
                                          size: 35.r,
                                          color: Colors.red,
                                        ))
                                  ],
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 4,
                          ),
                          ReadMoreText(
                            description,
                            trimLines: 10,
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Read less',
                            style: TextStyle(fontSize: 37.sp),
                            moreStyle: TextStyle(
                                fontSize: 38.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                            lessStyle: TextStyle(
                                fontSize: 38.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          title != "Daily Cleaning" && title != "InCarely"
                              ? Column(
                                  children: [
                                    Text(
                                      "Pilihan Paket",
                                      style: TextStyle(
                                          fontSize: 50.sp,
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
                                        discPercent: 0.0,
                                        hasVoucher: false,
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
                                    if (title != "Daily Cleaning" &&
                                        title != "InCarely") {
                                      var data = snapshot.data!.data![index];
                                      return Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 30.r, 30.r, 30.r),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(35.r),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(
                                                        0.2), // warna bayangan lembut
                                                    spreadRadius:
                                                        2, // seberapa jauh bayangan menyebar
                                                    blurRadius:
                                                        10, // seberapa lembut bayangan
                                                    offset: const Offset(0,
                                                        4), // posisi bayangan (x, y)
                                                  ),
                                                ],
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
                                                            },
                                                                "tambah",
                                                                profileController
                                                                    .hasVoucher
                                                                    .value,
                                                                data.discPercentage !=
                                                                    null);
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
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
                                                              .selectPackageDeep[
                                                          index] = !controller
                                                              .selectPackageDeep[
                                                          index];
                                                      if (controller
                                                              .selectPackageDeep[
                                                          index]) {
                                                        popupObjectPackage(
                                                            context, data, () {
                                                          controller
                                                                  .selectPackageDeep[
                                                              index] = false;
                                                        },
                                                            "tambah",
                                                            profileController
                                                                .hasVoucher
                                                                .value,
                                                            data.discPercentage !=
                                                                null);
                                                      } else {
                                                        controller
                                                            .resultDataObject
                                                            .removeWhere((element) =>
                                                                element[
                                                                    "pack_id"] ==
                                                                data.packId);
                                                      }
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      28.r),
                                                          child: CachedImage(
                                                            imgUrl:
                                                                data.packBannerPath ??
                                                                    "",
                                                            height: 190.w,
                                                            width: 190.w,
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
                                                                            3),
                                                              ),
                                                              child: Text(
                                                                "PROMO",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      24.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 35.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  controller.selectPackageDeep[
                                                                          index] =
                                                                      !controller
                                                                              .selectPackageDeep[
                                                                          index];
                                                                  if (controller
                                                                          .selectPackageDeep[
                                                                      index]) {
                                                                    popupObjectPackage(
                                                                        context,
                                                                        data,
                                                                        () {
                                                                      controller
                                                                              .selectPackageDeep[index] =
                                                                          false;
                                                                    },
                                                                        "tambah",
                                                                        profileController
                                                                            .hasVoucher
                                                                            .value,
                                                                        data.discPercentage !=
                                                                            null);
                                                                  } else {
                                                                    controller
                                                                        .resultDataObject
                                                                        .removeWhere((element) =>
                                                                            element["pack_id"] ==
                                                                            data.packId);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  data.packName! ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          42.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                            ),
                                                            (data.packCategory !=
                                                                    "Daily Cleaning")
                                                                ? TextButton
                                                                    .icon(
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5),
                                                                      minimumSize:
                                                                          Size(
                                                                              0,
                                                                              0),
                                                                      tapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Get.toNamed(
                                                                          "/package_description",
                                                                          arguments: {
                                                                            'packName':
                                                                                data.packName,
                                                                            'packImg':
                                                                                data.packBannerPath,
                                                                            'globalDesc':
                                                                                data.packGlobalDescription,
                                                                            'objectDesc':
                                                                                data.packObjectDescription,
                                                                            'jobDesc':
                                                                                data.packJobDescription,
                                                                          });
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .info_outline,
                                                                      size:
                                                                          45.r,
                                                                    ),
                                                                    label: Text(
                                                                      "Info",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              34.sp),
                                                                    ),
                                                                  )
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
                                                                          "$count Item",
                                                                          style:
                                                                              TextStyle(fontSize: 35.sp),
                                                                        ),
                                                                        Text(
                                                                            "Total : ${Utils.formatCurrency(controller.amountPriceperPackage(data.packId!))}",
                                                                            style:
                                                                                TextStyle(fontSize: 35.sp)),
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
                                                                        SizedBox(
                                                                          height:
                                                                              25,
                                                                          child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: Colors.blue, foregroundColor: Colors.white, textStyle: TextStyle(fontSize: 12)),
                                                                              onPressed: () {
                                                                                popupObjectPackage(context, data, () {
                                                                                  controller.selectPackageDeep[index] = false;
                                                                                }, "edit", profileController.hasVoucher.value, data.discPercentage != null);
                                                                              },
                                                                              child: Text(
                                                                                "Detail",
                                                                                style: TextStyle(fontSize: 34.sp),
                                                                              )),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              : SizedBox
                                                                  .shrink();
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 30.h,
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
                                        hasVoucher:
                                            profileController.hasVoucher.value,
                                        ontap: () {
                                          print(snapshot
                                              .data!.data![index].packId);
                                          controller.category.value = title;
                                          controller.selectedPackageId.value =
                                              snapshot
                                                  .data!.data![index].packId!
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
            title != "Daily Cleaning" && title != "InCarely"
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(45.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.2), // warna bayangan lembut
                          spreadRadius: 2, // seberapa jauh bayangan menyebar
                          blurRadius: 10, // seberapa lembut bayangan
                          offset: const Offset(0, 4), // posisi bayangan (x, y)
                        ),
                      ],
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 38.sp),
                                                  ),
                                                  Text(
                                                      Utils.formatCurrency(
                                                          normalTotal),
                                                      style: TextStyle(
                                                          fontSize: 38.sp,
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
                                                        fontSize: 38.sp,
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                      "- ${Utils.formatCurrency(normalTotal - total)}",
                                                      style: TextStyle(
                                                          fontSize: 38.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red)),
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
                                            fontSize: 38.sp,
                                          ),
                                        ),
                                        Text(Utils.formatCurrency(total),
                                            style: TextStyle(
                                                fontSize: 38.sp,
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
                                            fontSize: 38.sp,
                                          ),
                                        ),
                                        Text("$qty Item",
                                            style: TextStyle(
                                                fontSize: 38.sp,
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
                                backgroundColor:
                                    controller.resultDataObject.isNotEmpty
                                        ? Colors.blue
                                        : Colors.grey,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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
                                  fontSize: 38.sp,
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
      ),
    );
  }

  Future<dynamic> popupObjectPackage(
    BuildContext context,
    Data.Data data,
    VoidCallback onClose,
    String action,
    bool hasVoucher,
    bool hasPromo,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
       
        String truncateWithEllipsis(String text) {
           
           String normalizedText = text.replaceAll('\t', ' ');
           print(text);
          return (text.length >= 120) ? '${normalizedText.substring(0, 120)}...' : text;
        }

        return WillPopScope(
          onWillPop: () async {
            // Jalankan logika custom saat user tekan tombol back
            controller.tempDataObject.clear();

            if (action == "edit") {
              if (!controller.selectObjectPackage.any((e) => e)) {
                controller.resultDataObject.removeWhere(
                  (element) => element["pack_id"] == data.packId,
                );
                onClose();
              }
            } else {
              onClose();
            }

            // return true agar dialog benar-benar tertutup setelah kode dijalankan
            return true;
          },
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height - 500.w,
              width: MediaQuery.of(context).size.width - 100.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r)),
                              image: DecorationImage(
                                image: NetworkImage(data.packBannerPath!),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),

                          // 🔹 Lapisan 2: Overlay gradient putih dari bawah
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(30.r)),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color.fromARGB(230, 255, 255, 255),
                                    Color.fromARGB(164, 255, 255, 255), // atas
                                    Color.fromARGB(
                                        96, 255, 255, 255), // transparan penuh
                                  ],
                                  stops: [0.0, 0.6, 1.0],
                                ),
                              ),
                            ),
                          ),

                          // 🔹 Lapisan 3: Isi konten (teks dan tombol)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(45.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header baris atas
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.packName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 60.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.tempDataObject.clear();
                                        Get.back();

                                        if (action == "edit") {
                                          if (!controller.selectObjectPackage
                                              .any((e) => e)) {
                                            controller.resultDataObject
                                                .removeWhere(
                                              (element) =>
                                                  element["pack_id"] ==
                                                  data.packId,
                                            );
                                            onClose();
                                          }
                                        } else {
                                          onClose();
                                        }
                                      },
                                      child: const Icon(Icons.close,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    hasVoucher != false
                                        ? Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .red.shade300,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          LineIcons
                                                              .alternateTicket,
                                                          color: Colors.red,
                                                          size: 35.r,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          "Voucher Member",
                                                          style: TextStyle(
                                                            fontSize: 25.sp,
                                                            color: Colors
                                                                .red.shade400,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: -1,
                                                      right: -1,
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        size: 35.r,
                                                        color: Colors.red,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              )
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    hasPromo != false
                                        ? Stack(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.red.shade300,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      LineIcons.alternateTicket,
                                                      color: Colors.red,
                                                      size: 35.r,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      "Promo",
                                                      style: TextStyle(
                                                        fontSize: 25.sp,
                                                        color:
                                                            Colors.red.shade400,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: -1,
                                                  right: -1,
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    size: 35.r,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                                SizedBox(height: 45.h),

                                // Deskripsi + tombol selengkapnya
                                Stack(
                                  children: [
                                    Text(
                                      truncateWithEllipsis(
                                          data.packGlobalDescription ?? ""),
                                      maxLines: 4,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 35.sp,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed("/package_description",
                                              arguments: {
                                                'packName': data.packName,
                                                'packImg': data.packBannerPath,
                                                'globalDesc':
                                                    data.packGlobalDescription,
                                                'objectDesc':
                                                    data.packObjectDescription,
                                                'jobDesc':
                                                    data.packJobDescription,
                                              });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 4),
                                          child: Text(
                                            "Selengkapnya",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 38.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15.r, 15.r, 45.r, 15.r),
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
                                          controller
                                                  .selectObjectPackage[index] =
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
                                              "object_price": options[index]
                                                  .objectPriceDisc,
                                              "object_amount": controller
                                                  .amountObjectPackage[index],
                                            });
                                          } else {
                                            controller.tempDataObject
                                                .removeWhere((item) =>
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
                                                  controller
                                                          .selectObjectPackage[
                                                      index] = value!;
                                                  if (controller
                                                          .selectObjectPackage[
                                                      index]) {
                                                    controller.tempDataObject
                                                        .add({
                                                      "object_id":
                                                          options[index]
                                                              .objectId,
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
                                                        fontSize: 38.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    options[index]
                                                            .objectDescription ??
                                                        "",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 35.sp),
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
                                                (options[index]
                                                            .objectPriceDisc !=
                                                        options[index]
                                                            .objectPrice)
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              Utils.formatCurrency(
                                                                  options[index]
                                                                      .objectPriceDisc!),
                                                              style: TextStyle(
                                                                fontSize: 36.sp,
                                                              )),
                                                          Text(
                                                              Utils.formatCurrency(
                                                                  options[index]
                                                                      .objectPrice!),
                                                              style: TextStyle(
                                                                fontSize: 32.sp,
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
                                                        style: TextStyle(
                                                          fontSize: 36.sp,
                                                        )),
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
                                                              child:
                                                                  IconPlusMinus(
                                                                icon: Icons
                                                                    .remove,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30.r,
                                                                      vertical:
                                                                          15.r),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Colors
                                                                    .grey[100],
                                                              ),
                                                              child: Text(
                                                                  controller
                                                                      .amountObjectPackage[
                                                                          index]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          34.sp)),
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
                                                              child:
                                                                  IconPlusMinus(
                                                                icon: Icons.add,
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
                              padding: EdgeInsets.all(30.r),
                              child: Obx(() {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Item",
                                          style: TextStyle(fontSize: 38.sp),
                                        ),
                                        Text(
                                          controller
                                              .amountObjectQty()
                                              .toString(),
                                          style: TextStyle(fontSize: 38.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total Harga",
                                            style: TextStyle(fontSize: 38.sp)),
                                        Text(controller.amountObjectPrice(),
                                            style: TextStyle(fontSize: 38.sp)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              foregroundColor: Colors.white),
                                          onPressed: () {
                                            controller.addResultDataObject(
                                              data.packId!.toInt(),
                                              data.packName ?? "",
                                              data.packBannerPath ?? "",
                                              (data.discPercentage as num?)
                                                      ?.toDouble() ??
                                                  0.0,
                                              controller.tempDataObject
                                                  .toList(),
                                            );
                                            controller.tempDataObject.clear();

                                            Get.back();
                                          },
                                          child: Text(
                                            "Simpan",
                                            style: TextStyle(fontSize: 38.sp),
                                          )),
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

class IconPlusMinus extends StatelessWidget {
  final IconData icon;
  const IconPlusMinus({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.r,
      width: 60.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 45.r,
          color: Colors.black,
        ),
      ),
    );
  }
}
