import 'package:cleaning_app/controller/booking.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Detail Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
            future: controller.getDetailorder(),
            builder: (context, AsyncSnapshot<DetailOrderResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Skeletonizer(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("asdajsdasd"), Text("asdajsdasd")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("asdajsdasd"), Text("asdajsdasd")],
                    )
                  ],
                ));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No list packages found.');
              }
              final data = snapshot.data!.data!;

              final statusToStep = {
                "open": 0,
                "picked": 1,
                "progress": 2,
                "finish": 3,
              };
              controller.currentStep.value = statusToStep[data.orderStatus] ?? 0;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: controller.getStatusOrder(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' · ${controller.getDescriptionOrder()}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
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
                                  height: 70,
                                )
                              ]),
                          SizedBox(
                            // width: double.infinity,
                            height: 70,
                            child: Obx(() {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(controller.steps.length,
                                    (index) {
                                  return Expanded(
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.center,
                                      isFirst: index == 0,
                                      isLast:
                                          index == controller.steps.length - 1,
                                      beforeLineStyle: LineStyle(
                                        color: index <=
                                                controller.currentStep.value
                                            ? Colors.blue
                                            : Colors.grey.shade300,
                                        thickness: 4,
                                      ),
                                      afterLineStyle: LineStyle(
                                        color:
                                            index < controller.currentStep.value
                                                ? Colors.blue
                                                : Colors.grey.shade300,
                                        thickness: 4,
                                      ),
                                      indicatorStyle: IndicatorStyle(
                                        width: 30,
                                        height: 30,
                                        drawGap: true,
                                        indicatorXY: 0.5,
                                        indicator: index == 0
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6),
                                                child: Image.asset(
                                                    "assets/icon/icons.png"),
                                              )
                                            : Icon(
                                                controller.steps[index],
                                                color: index <=
                                                        controller
                                                            .currentStep.value
                                                    ? Colors.blue
                                                    : Colors.grey.shade400,
                                                size: 20,
                                              ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                          controller.currentStep.value == 0
                              ? Text(
                                  "Kami akan segera menginformasikan mitra yang akan melayani anda.")
                              : Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black54,
                                      child:
                                      data.partnerPhoto == null
                                          ? Text(
                                        data.partnerName![0].toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                          :
                                      ClipOval(
                                        child: Image.network(
                                          data.partnerPhoto!,
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Osem Irawan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Text("0851 5842 6044",
                                            style: TextStyle(fontSize: 13)),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: ()async{
                                        final phone = data.partnerPhone.toString();
                                        final url = 'https://wa.me/$phone';

                                        if (await canLaunchUrl(Uri.parse(url))) {
                                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                                        } else {
                                          print('Could not launch $url');
                                        }
                                      },
                                      child: Icon(
                                        LineIcons.whatSApp,
                                        color: Colors.green,
                                        size: 35,
                                      ),
                                    )
                                  ],
                                ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "LAYANAN",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(data.category!),
                                (data.category != "Daily Cleaning")
                                    ? Column(
                                        children: data.dataPack!.map((item) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.packName!,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Column(
                                                  children: item.dataObject!
                                                      .map((items) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("${items.objectName}"),
                                                    Text(Utils.formatCurrency(
                                                        int.parse(items
                                                            .objectPrice!))),
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
                                          Text(
                                              "${data.dataPack!.first.packName} (${data.dataPack!.first.packHour} Jam)"),
                                          Text(Utils.formatCurrency(
                                              data.dataPack!.first.packPrice!)),
                                        ],
                                      ),
                                Divider(),
                                Text(
                                  "LOKASI",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.propertyAddress!,
                                  maxLines: 3,
                                ),
                                Divider(),
                                Text(
                                  "TIPE PROPERTY",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.propertyType!,
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "JADWAL PESANAN",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(Utils.formatTanggal(data.dueDate!)),
                                Text(
                                  Utils.formatTime(data.dueTime!),
                                ),
                                Divider(),
                                Text(
                                  "CATATAN",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.orderNotes ?? "",
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
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "LAYANAN",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Harga Layanan"),
                                      Text(
                                          Utils.formatCurrency(data.subTotal!)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "BIAYA TRANSAKSI",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Discount"),
                                      Text(Utils.formatCurrency(
                                          data.nominalDiscount!)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PPN ${data.tax}%",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(Utils.formatCurrency(
                                          data.nominalTax!)),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("TOTAL PEMBAYARAN",style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                                      Text(Utils.formatCurrency(
                                          data.grandTotal!)),
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
                  data.orderStatus != "finish"
                  ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          showCancelDialog(context, data.orderid!.toInt());
                        },
                        child: Text("Batalkan Pesanan")),
                  )
                      : SizedBox.shrink()
                ],
              );
            }),
      ),
    );
  }

  void showCancelDialog(BuildContext context, int id) {
    final TextEditingController reasonController = TextEditingController();

    var optionReason = [
      "Salah Memasukkan Alamat",
      "Ingin Mengubah Produk Layanan",
      "Order dibuat Secara Tidak Sengaja"
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Container(
                width: 350,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Material(
                    color: Colors.transparent,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Text(
                        'Konfirmasi Pembatalan',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      const Text("Silakan isi alasan pembatalan:"),
                      const SizedBox(height: 10),
                      TextField(
                        controller: reasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Tulis alasan...",
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
                                        color: Colors.black,
                                      ),
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
}
