import 'package:cleaning_app/controller/booking.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/DetailOrderResponse.dart';
import '../../../widget/utils.dart';

class OrderDetail extends GetView<BookingController> {
  const OrderDetail({super.key});

  void showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: InteractiveViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchDetailOrder();
    return WillPopScope(
      onWillPop: () async {
        controller.detailOrder.value = null;
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Detail Order"),
        ),
        body: Padding(
          padding: EdgeInsets.all(43.r),
          child: Obx(() {
            final data = controller.detailOrder.value;

            if (data == null) {
              // loading skeleton
              return Skeletonizer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Loading..."), Text("Loading...")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Loading..."), Text("Loading...")],
                    ),
                  ],
                ),
              );
            }
            var result = data.data!;
            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.fetchDetailOrder,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                result.orderStatus == "new"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: "Menunggu Verifikasi",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 46.sp),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' · Pesananmu\nsedang diverifikasi oleh admin',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                      fontSize: 42.sp),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: controller
                                                      .getStatusOrder(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 46.sp),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' · ${controller.getDescriptionOrder()}',
                                                  style: TextStyle(
                                                    fontSize: 42.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                Image.asset(
                                  "assets/smartphone_icon.png",
                                  height: 190.h,
                                )
                              ]),
                          result.orderStatus != "new"
                              ? SizedBox(
                                  // width: double.infinity,
                                  height: 190.h,
                                  child: Obx(() {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(
                                          controller.steps.length, (index) {
                                        return Expanded(
                                          child: TimelineTile(
                                            axis: TimelineAxis.horizontal,
                                            alignment: TimelineAlign.center,
                                            isFirst: index == 0,
                                            isLast: index ==
                                                controller.steps.length - 1,
                                            beforeLineStyle: LineStyle(
                                              color: index <=
                                                      controller
                                                          .currentStep.value
                                                  ? Colors.blue
                                                  : Colors.grey.shade300,
                                              thickness: 4,
                                            ),
                                            afterLineStyle: LineStyle(
                                              color: index <
                                                      controller
                                                          .currentStep.value
                                                  ? Colors.blue
                                                  : Colors.grey.shade300,
                                              thickness: 4,
                                            ),
                                            indicatorStyle: IndicatorStyle(
                                              width: 80.w,
                                              height: 80.w,
                                              drawGap: true,
                                              indicatorXY: 0.5,
                                              indicator: index == 0
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 17.r),
                                                      child: Image.asset(
                                                          "assets/icon/icons.png"),
                                                    )
                                                  : Icon(
                                                      controller.steps[index],
                                                      color: index <=
                                                              controller
                                                                  .currentStep
                                                                  .value
                                                          ? Colors.blue
                                                          : Colors
                                                              .grey.shade400,
                                                      size: 20,
                                                    ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  }),
                                )
                              : SizedBox(
                                  height: 60.h,
                                ),
                          result.orderStatus == "new"
                              ? Text(
                                  "Kami akan segera menginformasikan setelah proses verifikasi selesai.",
                                  style: TextStyle(fontSize: 38.sp),
                                )
                              : controller.currentStep.value == 0
                                  ? Text(
                                      "Kami akan segera menginformasikan mitra yang akan melayani anda.",
                                      style: TextStyle(fontSize: 38.sp),
                                    )
                                  : Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 80.r,
                                          backgroundColor: Colors.grey,
                                          child: result.partnerPhoto == null
                                              ? Text(
                                                  result.partnerName![0]
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 50.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : ClipOval(
                                                  child: Image.network(
                                                    result.partnerPhoto!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  ),
                                                ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              result.partnerName!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 45.sp),
                                            ),
                                            Row(
                                              children: [
                                                Text(result.partnerPhone!,
                                                    style: TextStyle(
                                                        fontSize: 35.sp)),
                                                SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    Clipboard.setData(
                                                      ClipboardData(
                                                        text: result
                                                            .partnerPhone!,
                                                      ),
                                                    );
                                                    IconSnackBar.show(
                                                      context,
                                                      snackBarType:
                                                          SnackBarType.alert,
                                                      label:
                                                          'Text berhasil di salin.',
                                                    );
                                                  },
                                                  child: Icon(
                                                    LineIcons.copy,
                                                    color: Colors.black,
                                                    size: 40.r,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            final phone =
                                                result.partnerPhone.toString();
                                            final url = 'https://wa.me/$phone';

                                            if (await canLaunchUrl(
                                                Uri.parse(url))) {
                                              await launchUrl(Uri.parse(url),
                                                  mode: LaunchMode
                                                      .externalApplication);
                                            } else {
                                              print('Could not launch $url');
                                            }
                                          },
                                          child: Icon(
                                            LineIcons.whatSApp,
                                            color: Colors.green,
                                            size: 90.r,
                                          ),
                                        )
                                      ],
                                    ),
                          SizedBox(
                            height: 20.h,
                          ),
                           Divider(),
                          result.orderStatus == "finish"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sebelum",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 15.h),
                                    buildImageRow(
                                      context,
                                      result.dataDocuments!.first.imgBefore1!,
                                      result.dataDocuments!.first.imgBefore2!,
                                    ),
                                    SizedBox(height: 25.h),
                                    Text(
                                      "Setelah",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 15.h),
                                    buildImageRow(
                                      context,
                                      result.dataDocuments!.first.imgAfter1!,
                                      result.dataDocuments!.first.imgAfter2!,
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                          result.orderStatus == "finish"
                              ? Center(
                                  child: Container(
                                    padding: EdgeInsets.all(35.sp),
                                    color: Colors.grey[100],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        result.clientUpdate != 0
                                            ? Text(
                                                "Review dan Penilaian",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Beri Penilaian",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        foregroundColor:
                                                            Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(20
                                                                  .r), // <- Change radius here
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        controller.storeRating(
                                                            result.orderid!);
                                                      },
                                                      child: Text("Kirim")),
                                                ],
                                              ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Center(
                                          child: result.clientUpdate != 0
                                              ? RatingBar.builder(
                                                  itemSize: 28,
                                                  initialRating: double.parse(
                                                      result.clientRating
                                                          .toString()),
                                                  minRating: 1,
                                                  itemCount: 5,
                                                  unratedColor:
                                                      Colors.grey[300],
                                                  itemBuilder: (context, _) =>
                                                      const Icon(Icons.star,
                                                          color: Colors.amber),
                                                  onRatingUpdate: (value) {},
                                                  ignoreGestures: true,
                                                )
                                              : RatingBar.builder(
                                                  itemSize: 28,
                                                  initialRating: 0,
                                                  minRating: 1,
                                                  itemCount: 5,
                                                  unratedColor:
                                                      Colors.grey[300],
                                                  itemBuilder: (context, _) =>
                                                      const Icon(Icons.star,
                                                          color: Colors.amber),
                                                  onRatingUpdate: (value) {
                                                    print(
                                                        "User memberi rating: $value");
                                                    controller.rating.value =
                                                        value;
                                                  },
                                                ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        result.clientUpdate != 0
                                            ? Text(
                                                "Review : ${result.clientReview}")
                                            : TextField(
                                                maxLines: 3,
                                                controller:
                                                    controller.reviewController,
                                                style:
                                                    TextStyle(fontSize: 38.sp),
                                                decoration: InputDecoration(
                                                  hintText: "Review (Opsional)",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r),
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r),
                                                  ),
                                                  filled: true,
                                                  fillColor: Color(0xfff7f9fc),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        result.clientUpdate != 0
                                            ? SizedBox.shrink()
                                            : Column(
                                                children: [
                                                  Text(
                                                      "Apakah Mitra Menggunakan Atribut Utilizes GO?"),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor: controller
                                                                        .hasAttribute
                                                                        .value ==
                                                                    "ya"
                                                                ? Colors.blue
                                                                : Colors
                                                                    .grey[200],
                                                            foregroundColor:
                                                                controller.hasAttribute
                                                                            .value ==
                                                                        "ya"
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                          onPressed: () =>
                                                              controller
                                                                  .selectAnswer(
                                                                      "ya"),
                                                          child: Text("Ya")),
                                                      SizedBox(width: 30.w),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor: controller
                                                                        .hasAttribute
                                                                        .value ==
                                                                    "tidak"
                                                                ? Colors.red
                                                                : Colors
                                                                    .grey[200],
                                                            foregroundColor:
                                                                controller.hasAttribute
                                                                            .value ==
                                                                        "tidak"
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                          onPressed: () =>
                                                              controller
                                                                  .selectAnswer(
                                                                      "tidak"),
                                                          child: Text("Tidak")),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                         
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "LAYANAN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 38.sp),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  result.category!,
                                  style: TextStyle(
                                      fontSize: 38.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                (result.category != "Daily Cleaning")
                                    ? Column(
                                        children: result.dataPack!.map((item) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.packName!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 38.sp),
                                              ),
                                              Column(
                                                  children: item.dataObject!
                                                      .map((items) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        " • ${items.objectName} x ${items.qty}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 37.sp),
                                                      ),
                                                    ),
                                                    Text(
                                                      Utils.formatCurrency(
                                                          num.parse(items
                                                              .objectPrice!)),
                                                      style: TextStyle(
                                                          fontSize: 37.sp),
                                                    ),
                                                  ],
                                                );
                                              }).toList()),
                                            ],
                                          );
                                        }).toList(),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                " • ${result.dataPack!.first.packName} (${result.dataPack!.first.packHour} Jam)",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    TextStyle(fontSize: 37.sp)),
                                          ),
                                          Text(
                                              Utils.formatCurrency(result
                                                  .dataPack!.first.packPrice!),
                                              style:
                                                  TextStyle(fontSize: 37.sp)),
                                        ],
                                      ),
                                Divider(),
                                Text(
                                  "LOKASI",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 38.sp),
                                ),
                                Text(
                                  result.propertyAddress!,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 37.sp),
                                ),
                                Divider(),
                                Text(
                                  "TIPE PROPERTY",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 38.sp),
                                ),
                                Text(
                                  result.propertyType!,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 37.sp),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "JADWAL PESANAN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 38.sp),
                                ),
                                Text(
                                  Utils.formatTanggal(result.dueDate!),
                                  style: TextStyle(fontSize: 37.sp),
                                ),
                                Text(
                                  Utils.formatTime(result.dueTime!),
                                  style: TextStyle(fontSize: 37.sp),
                                ),
                                Divider(),
                                Text(
                                  "CATATAN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 38.sp),
                                ),
                                Text(
                                  result.orderNotes ?? "-",
                                  style: TextStyle(fontSize: 37.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.all(43.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Metode Pembayaran",
                                        style: TextStyle(fontSize: 38.sp),
                                      ),
                                      Text(
                                        result.paymentType!.toUpperCase(),
                                        style: TextStyle(fontSize: 38.sp),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal",
                                        style: TextStyle(fontSize: 38.sp),
                                      ),
                                      Text(
                                        Utils.formatCurrency(
                                            result.ttlBasicPrice!),
                                        style: TextStyle(fontSize: 38.sp),
                                      ),
                                    ],
                                  ),
                                  (result.ttlDiscPercent != 0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Discount",
                                              style: TextStyle(fontSize: 38.sp),
                                            ),
                                            Text(
                                              "- ${Utils.formatCurrency(result.ttlDiscNominal!)}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 38.sp),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  (result.propertyType == "Apartement")
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Apartement Fee",
                                              style: TextStyle(fontSize: 38.sp),
                                            ),
                                            Text(
                                              Utils.formatCurrency(
                                                  result.propertyCharge!),
                                              style: TextStyle(fontSize: 38.sp),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Biaya Platform",
                                        style: TextStyle(fontSize: 38.sp),
                                      ),
                                      Text(
                                        Utils.formatCurrency(
                                            result.platformCharge!),
                                        style: TextStyle(fontSize: 38.sp),
                                      ),
                                    ],
                                  ),
                                  (result.tax != 0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "PPN ${result.tax}%",
                                              style: TextStyle(fontSize: 38.sp),
                                            ),
                                            Text(
                                              Utils.formatCurrency(
                                                  result.nominalTax!),
                                              style: TextStyle(fontSize: 38.sp),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "TOTAL PEMBAYARAN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 38.sp),
                                      ),
                                      Text(
                                        Utils.formatCurrency(
                                            result.ttlSellingNominal!),
                                        style: TextStyle(fontSize: 38.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                result.orderStatus == "finish" ||
                        result.orderStatus == "progress"
                    ? SizedBox.shrink()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              showCancelDialog(
                                  context, result.orderid!.toInt());
                            },
                            child: Text("Batalkan Pesanan")),
                      )
              ],
            );
          }),
        ),
      ),
    );
  }

  void showCancelDialog(BuildContext context, int id) {
    final TextEditingController reasonController = TextEditingController();

    var optionReason = [
      "Salah Memasukkan Alamat",
      "Ingin Mengubah Jenis Layanan",
      "Order dibuat Secara Tidak Sengaja"
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 100.w,
                padding: EdgeInsets.all(30.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Material(
                    color: Colors.transparent,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        'Konfirmasi Pembatalan',
                        style: TextStyle(
                            fontSize: 55.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.h),
                      Text("Silakan isi alasan pembatalan:",
                          style: TextStyle(
                            fontSize: 40.sp,
                          )),
                      const SizedBox(height: 10),
                      TextField(
                        controller: reasonController,
                        maxLines: 3,
                        style: TextStyle(fontSize: 37.sp),
                        decoration: InputDecoration(
                          hintText: "Tulis alasan...",
                          hintStyle: TextStyle(fontSize: 37.sp),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            optionReason.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  reasonController.text = optionReason[index];
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: Text(
                                      optionReason[index],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 34.sp),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () =>
                                  Navigator.of(context).pop(), // Close dialog
                              child: const Text('Batal'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                final reason = reasonController.text.trim();
                                if (reason.isEmpty) {
                                  SnackbarUtil.show("Field Kosong",
                                      "Alasan tidak boleh kosong");
                                } else {
                                  var data = {
                                    "orderid": id,
                                    "cancel_reason": reason
                                  };
                                  controller.cancelOrder(data);
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      )
                    ]))));
      },
    );
  }

  Widget buildImageRow(BuildContext context, String img1, String img2) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => showImagePreview(context, img1),
            child: SizedBox(
              height: 150,
              child: Image.network(img1, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: GestureDetector(
            onTap: () => showImagePreview(context, img2),
            child: SizedBox(
              height: 150,
              child: Image.network(img2, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
