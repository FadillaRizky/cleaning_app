import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/controller/pemesanan.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';

class TagihanPage extends GetView<PemesananController> {
  PackageController packController = Get.put(PackageController());
  final String metodePembayaran;
  final int totalHarga;
  TagihanPage({
    super.key,
    required this.totalHarga,
    required this.metodePembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tagihan Pembayaran"),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card QRIS / Rekening
                      metodePembayaran == "QRIS"
                          ? SizedBox(
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset("assets/logo_qris.png",
                                              height: 25),
                                          Image.asset("assets/logo_gpn.png",
                                              height: 28),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "UTILIZES GO SERVICE",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "NMID : ID2025429865343",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        Utils.formatCurrency(totalHarga),
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.asset(
                                          "assets/QRIS.jpg",
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/icon/bca_white.png",
                                        height: 25),
                                    const SizedBox(height: 10),
                                   const Text(
                                      "PT. KUSUMA WIJAYA SENTOSA",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const Text(
                                      "Nomor Rekening",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "168 0370 628",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(
                                                const ClipboardData(
                                                    text:
                                                        "168 0370 628"));
                                            IconSnackBar.show(context,
                                                snackBarType:
                                                    SnackBarType.alert,
                                                label:
                                                    'Text berhasil disalin.');
                                          },
                                          child: const Text(
                                            "Salin",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                     

                      metodePembayaran == "QRIS"
                          ? Column(
                            children: [
                               const SizedBox(height: 10),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () =>
                                        controller.saveQrisToGallery(context),
                                    child: const Text("Download QRIS"),
                                  ),
                                ),
                            ],
                          )
                          : SizedBox.shrink(),

                      const SizedBox(height: 10),
                      Center(
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed("instruksi_pembayaran",arguments: {
                                  "metode_pembayaran": metodePembayaran
                                });
                              },
                              child: Text(
                                "Lihat Instruksi Pembayaran",
                                style: TextStyle(color: Colors.blue),
                              ))),
                      const SizedBox(height: 10),

                      // Disclaimer
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: Colors.red, size: 24),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Pastikan Anda melakukan pembayaran sesuai dengan total tagihan hingga 3 digit terakhir. "
                                "Pembayaran dengan nominal berbeda dapat menyebabkan transaksi tidak terverifikasi.",
                                style: TextStyle(
                                  color: Colors.orange.shade900,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Upload Bukti Transfer
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Upload Bukti Pembayaran",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Obx(() {
                        return Center(
                          child: GestureDetector(
                            onTap: controller.pickBuktiTransfer,
                            child: DottedBorder(
                              options: const RectDottedBorderOptions(
                                dashPattern: [8, 8],
                                color: Colors.blue,
                                strokeWidth: 2,
                                strokeCap: StrokeCap.round,
                              ),
                              child: controller.imageDocument.value == null
                                  ? Container(
                                      width: double.infinity,
                                      height: 150,
                                      color: Colors.grey[100],
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.cloud_upload,
                                              size: 50, color: Colors.blue),
                                          SizedBox(height: 8),
                                          Text(
                                            "Upload Bukti Disini",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: Image.file(
                                        controller.imageDocument.value!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 20),

                      // Tombol Konfirmasi
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // warna bayangan
                    spreadRadius: 1, // sebaran
                    blurRadius: 8, // tingkat blur
                    offset: const Offset(0, -2), // posisi bayangan (x, y)
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(Utils.formatCurrency(totalHarga),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (controller.imageDocument.value == null) {
                          SnackbarUtil.show("Tambahkan bukti pembayaran",
                              "Anda belum mengunggah bukti transfer. Harap unggah bukti pembayaran untuk melanjutkan.");
                          return;
                        }

                        if (packController.category.value != "Daily Cleaning") {
                          Map<String, dynamic> dataPackMap =
                              controller.getListDataPack();

                          var dataDeep = {
                            ...dataPackMap,
                            "category": packController.category.value,
                            "due_date": controller.dateText.value,
                            "due_time": controller.timeText.value,
                            "discount": "2",
                            "order_notes": controller.noteController.text,
                            "property_id": controller.propertyId.value,
                            "property_city": Utils.extractSecondSentence(
                                controller.propertyAddress.value),
                            "mitra_gender": controller.selectedGender.value,
                            "payment_type": metodePembayaran == "QRIS"
                                ? "qris"
                                : "bank transfer"
                          };
                          print(dataDeep);
                          controller.confirmPayment(dataDeep);
                        } else {
                          var dataDaily = {
                            "data_pack[0][pack_id]":
                                packController.selectedPackageId.value,
                            "data_pack[0][pack_category]":
                                packController.category.value,
                            "data_pack[0][pack_hour]":
                                packController.selectedDuration.value,
                            "data_pack[0][object_id]": "",
                            "data_pack[0][object_price]": "",
                            "category": packController.category.value,
                            "due_date": controller.dateText.value,
                            "due_time": controller.timeText.value,
                            "discount": "2",
                            "order_notes": controller.noteController.text,
                            "property_id": controller.propertyId.value,
                            "property_city": Utils.extractSecondSentence(
                                controller.propertyAddress.value),
                            "mitra_gender": controller.selectedGender.value,
                            "payment_type": metodePembayaran == "QRIS"
                                ? "qris"
                                : "bank transfer"
                          };
                          print(dataDaily);
                          controller.confirmPayment(dataDaily);
                        }
                      },
                      child: const Text("Saya Sudah Bayar"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  static TagihanPage fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return TagihanPage(
      metodePembayaran: args['metode_pembayaran'],
      totalHarga: args['total_harga'],
    );
  }
}
