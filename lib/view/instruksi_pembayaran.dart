import 'package:cleaning_app/controller/pemesanan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';

class InstructionPage extends GetView<PemesananController> {
  final String metodePembayaran;
  const InstructionPage({
    super.key,
    required this.metodePembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instruksi Pembayaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: metodePembayaran == "Bank Transfer"
                      ? Column(
                          children: [
                            Container(
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
                                                    text: "168 0370 628"));
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
                            SizedBox(
                              height: 10,
                            ),
                            ExpandListTile(
                              title: "ATM BCA",
                              children: [
                                buildStep(
                                    number: 1,
                                    "Masukkan kartu ",
                                    bold: "ATM",
                                    suffix: " dan ",
                                    bold2: "PIN BCA"),
                                buildStep(
                                    number: 2,
                                    "Pilih menu ",
                                    bold:
                                        "MENU LAINNYA > TRANSFER > KE REK BCA"),
                                buildStep(
                                    number: 3,
                                    "Masukkan ",
                                    bold: "1680370628",
                                    color: Colors.red,
                                    suffix: " sebagai rekening tujuan"),
                                buildStep(
                                    number: 4,
                                    "Masukkan jumlah yang ingin dibayarkan"),
                                buildStep(
                                    number: 5,
                                    "Pastikan rekening tujuan atas nama ",
                                    bold: "PT. KUSUMA WIJAYA SENTOSA"),
                                buildStep(
                                    number: 6,
                                    "Ikuti instruksi untuk menyelesaikan transaksi"),
                              ],
                            ),
                            ExpandListTile(
                              title: "KlikBCA",
                              children: [
                                buildStep(
                                  number: 1,
                                  "Masuk ke website ",
                                  bold: "KLIK BCA",
                                ),
                                buildStep(
                                    number: 2,
                                    "Pilih menu ",
                                    bold:
                                        "TRANSFER DANA > TRANSFER KE REK. BCA"),
                                buildStep(
                                    number: 3,
                                    "Pilih ",
                                    bold: "1680370628",
                                    color: Colors.red,
                                    suffix: " sebagai rekening tujuan"),
                                buildStep(
                                    number: 4,
                                    "Masukkan jumlah yang ingin dibayarkan"),
                                buildStep(
                                    number: 5,
                                    "Pastikan rekening tujuan atas nama ",
                                    bold: "PT. KUSUMA WIJAYA SENTOSA"),
                                buildStep(
                                    number: 6,
                                    "Ikuti instruksi untuk menyelesaikan transaksi"),
                              ],
                            ),
                            ExpandListTile(
                              title: "m-BCA",
                              children: [
                                buildStep(
                                    number: 1,
                                    "Buka aplikasi ",
                                    bold: "BCA Mobile ",
                                    suffix: "masukan kode akse untuk",
                                    bold2: "LOGIN"),
                                buildStep(
                                    number: 2,
                                    "Pilih menu ",
                                    bold: "M-TRANSFER > ANTAR REKENING"),
                                buildStep(
                                    number: 3,
                                    "Pilih ",
                                    bold: "1680370628",
                                    color: Colors.red,
                                    suffix: " sebagai rekening tujuan"),
                                buildStep(
                                    number: 4,
                                    "Masukkan jumlah yang ingin dibayarkan"),
                                buildStep(
                                    number: 5,
                                    "Pastikan rekening tujuan atas nama ",
                                    bold: "PT. KUSUMA WIJAYA SENTOSA"),
                                buildStep(
                                    number: 6,
                                    "Ikuti instruksi untuk menyelesaikan transaksi"),
                              ],
                            ),
                            ExpandListTile(
                              title: "Antar Bank",
                              children: [
                                buildStep(
                                  number: 1,
                                  "Lakukan langkah tranfer sesuai dengan instruksi bank anda",
                                ),
                                buildStep(
                                    number: 2,
                                    "Daftar rekening, masukan kode ",
                                    bold: "014 ",
                                    suffix: "untuk bank konvensional dan ",
                                    bold2: "536 ",
                                    suffix2:
                                        "untuk bank syariah lalu nomor rekening ",
                                    bold3: "1680370628 ",
                                    suffix3: "atas nama ",
                                    bold4: "PT. KUSUMA WIJAYA SENTOSA"),
                                buildStep(
                                    number: 3,
                                    "Pilih ",
                                    bold: "1680370628",
                                    color: Colors.red,
                                    suffix: " sebagai rekening tujuan"),
                                buildStep(
                                    number: 4,
                                    "Masukkan jumlah yang ingin dibayarkan"),
                                buildStep(
                                    number: 5,
                                    "Pastikan rekening tujuan atas nama ",
                                    bold: "PT. KUSUMA WIJAYA SENTOSA"),
                                buildStep(
                                    number: 6,
                                    "Ikuti instruksi untuk menyelesaikan transaksi"),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                shrinkWrap:
                                    true, // ✅ penting kalau gridview ada di dalam Column/ScrollView
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Image.asset("assets/icon/step1.png",
                                      fit: BoxFit.contain),
                                  Image.asset("assets/icon/step2.png",
                                      fit: BoxFit.contain),
                                  Image.asset("assets/icon/step3.png",
                                      fit: BoxFit.contain),
                                  Image.asset("assets/icon/step4.png",
                                      fit: BoxFit.contain),
                                ],
                              ),
                            ),
                            buildStep(
                                number: 1,
                                "Klik tombol ",
                                bold: "Unduh QRIS ",
                                suffix: "untuk menyimpan QR Code."),
                            buildStep(
                                number: 2,
                                "Kemudian buka e-wallet atau m-banking pilihanmu yang mendukung layanan QRIS."),
                            buildStep(
                                number: 3,
                                "Upload gambar QR Code ",
                                bold: "Utilizes GO Service ",
                                suffix: "yang sudah di unduh."),
                            buildStep(
                                number: 4,
                                "Masukkan jumlah yang ingin dibayarkan, pastikan jumlah hingga ",
                                bold: "3 digit terakhir."),
                            buildStep(
                                number: 5,
                                "Pastikan tujuan penerima yaitu ",
                                bold: "Utilizes GO Service."),
                            buildStep(
                                number: 6,
                                "Klik konfirmasi dan ",
                                bold: "bayar."),
                            buildStep(
                                number: 7,
                                "Buka kembali aplikasi ",
                                bold: "Utilizes GO ",
                                suffix:
                                    "dan cek status transaksimu di pesananmu."),
                          ],
                        )),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static InstructionPage fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return InstructionPage(
      metodePembayaran: args['metode_pembayaran'],
    );
  }

  Widget buildStep(String prefix,
      {String? bold,
      String? bold2,
      String? bold3,
      String? bold4,
      String? suffix,
      String? suffix2,
      String? suffix3,
      required int number,
      Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number. ",style: const TextStyle(color: Colors.black, fontSize: 14)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                children: [
                  TextSpan(text: prefix),
                  if (bold != null)
                    TextSpan(
                      text: bold,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color ?? Colors.black),
                    ),
                  if (suffix != null) TextSpan(text: suffix),
                  if (bold2 != null)
                    TextSpan(
                      text: bold2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  if (suffix2 != null) TextSpan(text: suffix2),
                  if (bold3 != null)
                    TextSpan(
                      text: bold3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color ?? Colors.black),
                    ),
                  if (suffix3 != null) TextSpan(text: suffix3),
                  if (bold4 != null)
                    TextSpan(
                      text: bold4,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color ?? Colors.black),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandListTile extends StatelessWidget {
  final List<Widget> children;
  final String title;
  const ExpandListTile({
    super.key,
    required this.children,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 15),
            children: [
              TextSpan(text: "Petunjuk Transfer "),
              TextSpan(
                text: title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        children: children,
      ),
    );
  }
}
