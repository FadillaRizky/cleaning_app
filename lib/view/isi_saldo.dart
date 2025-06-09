import 'package:cleaning_app/controller/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

import '../widget/utils.dart';

class IsiSaldo extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Isi Saldo"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nominal Isi Saldo",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyInputFormatter()],
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 10, top: 12, bottom: 12),
                          child: Text(
                            'Rp',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        isDense: true,
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: controller.onChanged,
                    ),
                    const SizedBox(height: 8),
                    Obx(() => controller.showError.value
                            ? Text(
                                'Saldo minimal 20.000',
                                style: TextStyle(color: Colors.red, fontSize: 14),
                              )
                            : SizedBox
                                .shrink() // or Container() to render nothing
                        ),
                    Divider(),
                    Text(
                      "Pilih Bank",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Obx(() {
                      return Column(
                          children: controller.listBank.map<Widget>((item) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(
                            "assets/icon/$item.png",
                            height: 20,
                          ),
                          trailing: Radio(
                              value: item,
                              groupValue: controller.selectBank.value,
                              onChanged: (value) {
                                controller.selectBank.value = value!;
                              }),
                        );
                      }).toList());
                    })
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            var enable = controller.topupText.value.isNotEmpty &&
                !controller.showError.value && controller.selectBank.value != "";
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: enable ? Colors.blue : Colors.grey,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Get.toNamed("/upload-bukti-topup");
                  },
                  child: Text("Lanjutkan")),
            );
          })
        ],
      ),
    );
  }
}

class UploadBuktiTopup extends GetView<HomeController> {
  const UploadBuktiTopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Isi Saldo"),
      ),
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icon/bca.png",
                        height: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "PT Utilizes International",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Nomor Rekening"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("123 456 789"),
                          GestureDetector(
                            onTap: (){
                              Clipboard.setData(ClipboardData(text: "123 456 789"));
                              IconSnackBar.show(context,snackBarType: SnackBarType.alert, label: 'Text berhasil di salin.');
                            },
                            child: Text(
                              "Salin",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Total Pembayaran",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Utils.formatCurrency(int.parse(controller
                                .topupText.value
                                .replaceAll(RegExp(r'[^0-9]'), ''))),
                            style: TextStyle(
                                fontSize: 33, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: (){
                              Clipboard.setData(ClipboardData(text: controller
                                  .topupText.value
                                  .replaceAll(RegExp(r'[^0-9]'), '')));
                              IconSnackBar.show(context,snackBarType: SnackBarType.alert, label: 'Text berhasil di salin.');
                            },
                            child: Text(
                              "Salin",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "*Transfer hingga 3 digit terakhir",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "*Deposit yang akan anda terima sebesar Rp. 150.020",
                        style: TextStyle(fontSize: 10),
                      ),
                      Divider(),
                      Text(
                        "Upload Bukti Pembayaran",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "*Transaksi Anda tidak akan kami proses sebelum menekan tombol Konfirmasi Pembayaran",
                          style: TextStyle(fontSize: 10)),
                      Text(
                          "*Pastikan foto atau screenshot bukti transfer terbaca jelas",
                          style: TextStyle(fontSize: 10)),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return Center(
                          child: GestureDetector(
                              onTap: controller.pickBuktiTopup,
                              child: DottedBorder(
                                options: RectDottedBorderOptions(
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
                                          children: [
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
                              )),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black12,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: Text("Batalkan Transaksi")),
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
                          String nominal = controller.topupText.value
                              .replaceAll(RegExp(r'[^0-9]'), '');
                          controller.uploadDocumentTopup(nominal);
                        },
                        child: Text("Konfirmasi Pembayaran")),
                  ),
                ],
              ),
            ),
          ],
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return AbsorbPointer(
              absorbing: true, // mencegah interaksi
              child: Container(
                color: Colors.black.withOpacity(0.5), // semi transparan
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink(); // tidak tampil
          }
        }),
      ]),
    );
  }
}

class TopupSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset(
              "assets/icon/loading.svg",
              height: 180,
            ),
            SizedBox(height: 100,),
            Text(
              "Mohon Tunggu",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Kami akan segera memproses \n pembayaran anda.",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey)
                  ),
                  onPressed: () {
                    Get.toNamed("/info-saldo");
                  },
                  child: Text("Riwayat Transaksi")),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Get.offNamed("/menu");
                  },
                  child: Text("Kembali ke Beranda")),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
