import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/detail_daily_cleaning.dart';
import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/DurationPackageResponse.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:cleaning_app/widget/cached_image.dart';
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
  final double? discPercent;

  DetailDailyCleaning({
    super.key,
    required this.id,
    required this.title,
    this.discPercent,
  });

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    print("dddd : ${discPercent != null}");
    return WillPopScope(
      onWillPop: () async {
        controller.resetSelection();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              controller.resetSelection();
            },
          ),
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
      ),
    );
  }

  Widget detailPackage(
      DetailPackageResponse detail,
      DurationPackageResponse duration,
      // PropertyAddressResponse property,
      BuildContext context) {
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
                          return SelectDuration(
                            controller: controller,
                            ph_id: duration.data![index].phId!.toInt(),
                            title: duration.data![index].packHour!.toInt(),
                            normalPrice:
                                duration.data![index].packPrice!.toInt(),
                            realPrice:
                                duration.data![index].packPriceDisc!.toInt(),
                          );
                        },
                      ),
                      Divider(),
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
                            widgetContent: ListView.builder(
                                itemCount: detail.data!.pdesc!.length,
                                itemBuilder: (content, index) {
                                  final data = detail.data!.pdesc![index];
                                  return ListTile(
                                    leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedImage(
                                            imgUrl: data.pdescImgPath!,
                                            height: 70,
                                            width: 70)),
                                    title: Text(data.pdescTitle!),
                                    subtitle: Text(data.pdescDetail!),
                                  );
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          cardLayanan(
                            path: '././assets/icon/detail_pengerjaan.svg',
                            title: 'Detail Pengerjaan',
                            widgetContent: SingleChildScrollView(
                              child:
                                  Text(detail.data!.pack!.packJobDescription!),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          cardLayanan(
                            path: '././assets/icon/peralatan.svg',
                            title: 'Peralatan',
                            widgetContent: SingleChildScrollView(
                              child: Text(
                                  detail.data!.pack!.packObjectDescription!),
                            ),
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
      ((discPercent != null && discPercent != 0.0) || profileController.hasVoucher.value ) && controller.selectedPriceDuration.value != ""
          ? Column(
              children: [
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subtotal",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        Utils.formatCurrency(
                          int.tryParse(controller.selectedDiscount.value) ?? 0,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${profileController.hasVoucher.value ? "Voucher Member" : ""}"
                      "${profileController.hasVoucher.value && discPercent != null && discPercent != 0.0 ? " + " : ""}"
                      "${(discPercent != null && discPercent != 0.0) ? "Promo" : ""}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      Utils.formatCurrency(
                        (int.tryParse(controller.selectedPriceDuration.value) ?? 0) -
                        (int.tryParse(controller.selectedDiscount.value) ?? 0),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox.shrink(),
                  controller.selectedPriceDuration.value != ""
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    Utils.formatCurrency(int.parse(controller
                                        .selectedPriceDuration.value)),
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
                        backgroundColor:
                            controller.selectedPriceDuration.value != ""
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
                              controller.selectedPackageName.value =
                                  detail.data!.pack!.packName!;
                              controller.selectedPackageImg.value =
                                  detail.data!.pack!.packBannerPath ?? "";
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
      discPercent: (args['discPercent'] is num)
          ? (args['discPercent'] as num).toDouble()
          : null,
    );
  }
}

class cardLayanan extends StatelessWidget {
  final String path;
  final String title;
  final Widget widgetContent;

  const cardLayanan({
    super.key,
    required this.path,
    required this.title,
    required this.widgetContent,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  height: 500,
                  width: 350,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                        Divider(),
                        Expanded(child: widgetContent)
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

class SelectDuration extends StatelessWidget {
  final int ph_id;
  final int title;
  final int normalPrice;
  final int realPrice;
  final PackageController controller;

  const SelectDuration({
    super.key,
    required this.ph_id,
    required this.title,
    required this.normalPrice,
    required this.realPrice,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    print("normalPrice : $normalPrice");
    print("realprice : $realPrice");
    return Obx(() {
      return RadioListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          "$title Jam",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        secondary: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (normalPrice != realPrice)
                ? Text(
                    Utils.formatCurrency(normalPrice).toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(width: 8),
            Text(
              Utils.formatCurrency(realPrice).toString(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // ✅ gunakan ph_id sebagai value utama
        value: ph_id.toString(),
        groupValue: controller.selectedPhId.value,
        onChanged: (value) {
          controller.selectedPhId.value = value!;
          controller.selectedDuration.value = title.toString();
          controller.selectedPriceDuration.value = realPrice.toString();
          controller.selectedDiscount.value = normalPrice.toString();
        },
      );
    });
  }
}
