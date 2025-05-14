import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/detail_daily_cleaning.dart';
import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/DurationPackageResponse.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailDailyCleaning extends GetView<DetailDailyController> {
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
            final detail = snapshot.data!['data1'] as DetailPackageResponse;
            final duration = snapshot.data!['data2'] as DurationPackageResponse;
            return detailPackage(detail,duration, context);
          }),
    );
  }

  Widget detailPackage(
      DetailPackageResponse detail, DurationPackageResponse duration ,BuildContext context) {
    // print("total duration : ${duration.data!.length}");
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
                      Text(
                        detail.data!.pack!.packObjectDescription!,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pilih Alamat",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 5, right: 0),
                        leading: Icon(Icons.home),
                        title: Text(
                          "Sarah Novianti",
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          "Jl. Cenderawasih Tangerang Banten",
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {},
                          child: Text("Ubah"),
                        ),
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
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // print("duration.data!.length");/
                          // print(duration.data!.length);
                          return selectDuration(
                            controller: controller,
                            title: duration.data![index].packHour.toString(),
                            normalPrice: duration.data![index].packPriceDisc.toString(),
                            realPrice: duration.data![index].packPrice.toString(),
                          );
                        },
                      ),
                      // selectDuration(
                      //   controller: controller,
                      //   title: "2 Jam",
                      //   normalPrice: "125.000",
                      //   realPrice: "100.000",
                      // ),
                      // selectDuration(
                      //   controller: controller,
                      //   title: "3 Jam",
                      //   normalPrice: "175.000",
                      //   realPrice: "150.000",
                      // ),
                      // selectDuration(
                      //   controller: controller,
                      //   title: "4 Jam",
                      //   normalPrice: "225.000",
                      //   realPrice: "200.000",
                      // ),
                      // selectDuration(
                      //   controller: controller,
                      //   title: "5 Jam",
                      //   normalPrice: "260.000",
                      //   realPrice: "250.000",
                      // ),
                      // selectDuration(
                      //   controller: controller,
                      //   title: "6 Jam",
                      //   normalPrice: "350.000",
                      //   realPrice: "300.000",
                      // ),
                      Divider(),
                      Text(
                        "Pilih Waktu Layanan",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Tanggal",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.dateController,
                        decoration: InputDecoration(
                          hintText: "Pilih Tanggal",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color(0xfff7f9fc),
                        ),
                        readOnly: true,
                        onTap: () {
                          controller.selectDate(context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Waktu",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.timeController,
                        decoration: InputDecoration(
                          hintText: "Pilih Waktu",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.access_time_outlined,
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color(0xfff7f9fc),
                        ),
                        readOnly: true,
                        onTap: () {
                          // controller.selectTime(context);
                          Navigator.push(
                              context,
                              showPicker(
                                context: context,
                                value: Time(hour: 11, minute: 30, second: 20),
                                sunrise: TimeOfDay(hour: 6, minute: 0),
                                // optional
                                sunset: TimeOfDay(hour: 18, minute: 0),
                                // optional
                                is24HrFormat: true,
                                duskSpanInMinutes: 120,
                                // optional
                                minHour: 8,
                                maxHour: 18,
                                onChange: (time) {
                                  String formattedTime =
                                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                  controller.timeController.text =
                                      formattedTime;
                                },
                              ));
                        },
                      ),
                      SizedBox(
                        height: 5,
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          cardLayanan(
                            path: '././assets/icon/detail_pengerjaan.svg',
                            title: 'Detail Pengerjaan',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          cardLayanan(
                            path: '././assets/icon/peralatan.svg',
                            title: 'Peralatan',
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
                  controller.selectedDuration.value != ""
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
                                      "Rp ${controller.selectedDuration.value}",
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
                                Text("-Rp 100.000",
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
                                Text("Rp 302.000",
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
                        backgroundColor: controller.selectedDuration.value != ""
                            ? Colors.blue
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide.none,
                        ),
                      ),
                      onPressed: controller.selectedDuration.value != ""
                          ? () {
                              Get.toNamed("/pembayaran");
                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   backgroundColor:
                              //       Colors.transparent, // make the background transparent
                              //   builder: (context) {
                              //     return Container(
                              //       decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.only(
                              //           topLeft: Radius.circular(20),
                              //           topRight: Radius.circular(20),
                              //         ),
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(16.0),
                              //         child: Column(
                              //           mainAxisSize: MainAxisSize.min,
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   'Daily Cleaning',
                              //                   style: TextStyle(
                              //                       fontSize: 18,
                              //                       fontWeight: FontWeight.bold),
                              //                 ),
                              //                 GestureDetector(
                              //                     onTap: () {
                              //                       Navigator.pop(context);
                              //                     },
                              //                     child: Icon(Icons.close))
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             ),
                              //             Text(
                              //               "Peralatan",
                              //               style: TextStyle(fontWeight: FontWeight.bold),
                              //             ),
                              //             ListTile(
                              //               contentPadding: EdgeInsets.zero,
                              //               leading: Radio(
                              //                   value: true,
                              //                   groupValue: () {},
                              //                   onChanged: (t) {}),
                              //               title: Text("Dengan Alat"),
                              //               subtitle: Text(
                              //                   "Peralatan dan perlengkapan untuk pembersihan dibawa oleh mitra."),
                              //             ),
                              //             ListTile(
                              //               contentPadding: EdgeInsets.zero,
                              //               leading: Radio(
                              //                   value: true,
                              //                   groupValue: () {},
                              //                   onChanged: (t) {}),
                              //               title: Text("Tanpa Alat"),
                              //               subtitle: Text(
                              //                   "Peralatan dan perlengkapan untuk pembersihan hunian umum disediakan oleh pelanggan."),
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             ),
                              //             Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   "Durasi Pengerjaan (Jam)",
                              //                   style: TextStyle(fontWeight: FontWeight.bold),
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     GestureDetector(
                              //                       onTap: () {},
                              //                       child: Container(
                              //                         width: 30,
                              //                         height: 30,
                              //                         decoration: BoxDecoration(
                              //                             borderRadius: BorderRadius.only(
                              //                                 topLeft: Radius.circular(5),
                              //                                 bottomLeft: Radius.circular(5)),
                              //                             border: Border(
                              //                                 top: BorderSide(width: 0.5),
                              //                                 left: BorderSide(width: 0.5),
                              //                                 bottom:
                              //                                     BorderSide(width: 0.5))),
                              //                         child: Center(child: Text("-")),
                              //                       ),
                              //                     ),
                              //                     Container(
                              //                       width: 30,
                              //                       height: 30,
                              //                       decoration: BoxDecoration(
                              //                           border: Border.all(width: 0.5)),
                              //                       child: Center(child: Text("2")),
                              //                     ),
                              //                     Container(
                              //                       width: 30,
                              //                       height: 30,
                              //                       decoration: BoxDecoration(
                              //                           borderRadius: BorderRadius.only(
                              //                               topRight: Radius.circular(5),
                              //                               bottomRight: Radius.circular(5)),
                              //                           border: Border(
                              //                               top: BorderSide(width: 0.5),
                              //                               right: BorderSide(width: 0.5),
                              //                               bottom: BorderSide(width: 0.5))),
                              //                       child: Center(child: Text("+")),
                              //                     ),
                              //                   ],
                              //                 )
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   "Diskon 10%",
                              //                   style: TextStyle(
                              //                       fontStyle: FontStyle.italic,
                              //                       color: Colors.blue),
                              //                 ),
                              //                 Text("Rp 330.000",
                              //                     style: TextStyle(
                              //                         fontSize: 16,
                              //                         fontWeight: FontWeight.bold)),
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             ),
                              //             SizedBox(
                              //               width: double.infinity,
                              //               child: ElevatedButton(
                              //                   style: ElevatedButton.styleFrom(
                              //                     backgroundColor: Colors.blue,
                              //                     padding: const EdgeInsets.symmetric(
                              //                         vertical: 12),
                              //                     shape: RoundedRectangleBorder(
                              //                       borderRadius: BorderRadius.circular(10),
                              //                       side: BorderSide.none,
                              //                     ),
                              //                   ),
                              //                   onPressed: () {
                              //                     Navigator.pop(context);
                              //                   },
                              //                   child: Text("Lanjutkan",
                              //                       style: TextStyle(
                              //                         color: Colors.white,
                              //                       ))),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
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

  const cardLayanan({
    super.key,
    required this.path,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}

class selectDuration extends StatelessWidget {
  final String title;
  final String normalPrice;
  final String realPrice;

  const selectDuration({
    super.key,
    required this.controller,
    required this.title,
    required this.normalPrice,
    required this.realPrice,
  });

  final DetailDailyController controller;

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
                "Rp $normalPrice",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 8),
              Text("Rp $realPrice",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          value: realPrice,
          groupValue: controller.selectedDuration.value,
          onChanged: (value) {
            controller.selectedDuration.value = value!;
          });
    });
  }
}
