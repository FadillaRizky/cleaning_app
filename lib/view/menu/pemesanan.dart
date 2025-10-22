import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:cleaning_app/view/menu/voucher.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/pemesanan.dart';
import '../../widget/utils.dart';

class Pemesanan extends GetView<PemesananController> {
  PackageController packController = Get.put(PackageController());
  HomeController homeController = Get.put(HomeController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pemesanan"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<PemesananController>(builder: (_) {
                      return FutureBuilder(
                          future: controller.listAddressFuture,
                          builder: (context,
                              AsyncSnapshot<PropertyAddressResponse> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Skeletonizer(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 0),
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
                            } else if (snapshot.hasData &&
                                snapshot.data!.data!.isNotEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final data = snapshot.data!.data!.first;
                                controller.picName.value = data.picName!;
                                controller.propertyAddress.value =
                                    data.propertyAddress!;
                                controller.propertyId.value =
                                    data.id.toString();
                                controller.propertyType.value =
                                    data.propertyType.toString();
                                controller.selectedProperty.value =
                                    data.id!.toInt();
                              });

                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Alamat",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Divider(),
                                    Obx(() {
                                      return ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 5, right: 0),
                                        leading: Icon(Icons.home),
                                        title: Text(
                                          controller.picName.value,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        subtitle: Text(
                                          controller.propertyAddress.value,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        trailing: TextButton(
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {
                                            selectAddress(context, snapshot);
                                          },
                                          child: Text("Ubah"),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              );
                            }

                            return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Alamat",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(),
                                    ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 5, right: 0),
                                        title: Text(
                                          "Tambah Alamat ",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        subtitle: Text(
                                          "Alamat belum ditambahkan",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        trailing: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () async {
                                            var result = await Get.toNamed(
                                                "/tambah-alamat");
                                            if (result == 'refresh') {
                                              controller.refreshAddress();
                                            }
                                          },
                                          label: Text("Tambah"),
                                          icon: Icon(LineIcons.plus),
                                        ))
                                  ],
                                ));
                          });
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pesanan Anda",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Divider(),
                          Text(packController.category.value,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          packController.category.value != "Daily Cleaning"
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      packController.resultDataObject.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl: packController
                                                            .resultDataObject[
                                                        index]['pack_img'],
                                                    fit: BoxFit.cover,
                                                    height: 70,
                                                    width: 70,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.person,
                                                      size: 60,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                if (packController
                                                            .resultDataObject[
                                                        index]['pack_disc'] !=
                                                    0)
                                                  Positioned(
                                                    top: 4,
                                                    left: 4,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.redAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Text(
                                                        "- ${packController.resultDataObject[index]['pack_disc']} %",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(width: 15),
                                            // Gunakan Expanded di sini agar teks bisa wrap
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          packController
                                                                  .resultDataObject[
                                                              index]['pack_name'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      if (packController
                                                                  .resultDataObject[
                                                              index]['pack_disc'] !=
                                                          0)
                                                        Row(
                                                          children: const [
                                                            Icon(
                                                              LineIcons
                                                                  .alternateTicket,
                                                              color: Colors.red,
                                                              size: 13,
                                                              weight: 10,
                                                            ),
                                                            SizedBox(width: 3),
                                                            Text(
                                                              "Dengan Promo",
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: packController
                                                        .resultDataObject[index]
                                                            ["data_object"]
                                                        .map<Widget>((item) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 2),
                                                        child: Text(
                                                          "\u2022 ${item['object_name']}    x ${item['object_amount']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: packController
                                            .selectedPackageImg.value,
                                        fit: BoxFit.cover,
                                        height: 70,
                                        width: 70,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            packController
                                                .selectedPackageName.value,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${packController.selectedDuration.value} Jam",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                Utils.formatCurrency(int.parse(
                                                    packController
                                                        .selectedPriceDuration
                                                        .value)),
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        voucherModal(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  LineIcons.alternateTicket,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Voucher Anda",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                (profileController.hasVoucher.value)
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red.shade300,
                                              width: 1),
                                          // borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          "- ${profileController.valueVoucher.value} %",
                                          style: TextStyle(
                                              fontSize: 11, color: Colors.red),
                                        ))
                                    : SizedBox.shrink(),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.grey,
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
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Metode Pembayaran",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Divider(),
                          RadioPayment(
                            controller: controller,
                            value: 'Saldo',
                            title: "Saldo",
                            icon: Icons.account_balance_wallet,
                          ),
                          RadioPayment(
                            controller: controller,
                            value: 'QRIS',
                            title: "QRIS",
                            icon: Icons.qr_code,
                          ),
                          RadioPayment(
                            controller: controller,
                            value: 'Bank Transfer',
                            title: "Bank Transfer",
                            icon: Icons.account_balance,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Waktu Layanan",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Divider(),
                          TextField(
                            controller: controller.dateController,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              hintText: "Pilih Tanggal",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.grey,
                                size: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
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
                          TextField(
                            controller: controller.timeController,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              hintText: "Pilih Waktu",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.access_time_outlined,
                                color: Colors.grey,
                                size: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Color(0xfff7f9fc),
                            ),
                            readOnly: true,
                            onTap: () {
                              controller.selectTime(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tambahan",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          TextField(
                            maxLines: 3,
                            controller: controller.noteController,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              hintText: "Catatan (Opsional)",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Color(0xfff7f9fc),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Gender Mitra",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(() {
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Pilih',
                                hintStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Color(0xfff7f9fc),
                                // contentPadding: EdgeInsets.symmetric(vertical: 10)
                              ),
                              value: controller.selectedGender.value == ''
                                  ? null
                                  : controller.selectedGender.value,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              items: controller.genderMitra.map((fruit) {
                                return DropdownMenuItem<String>(
                                  value: fruit,
                                  child: Text(fruit),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  controller.selectedGender.value = val!,
                            );
                          }),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "* Opsi ini dapat Anda sesuaikan apabila menginginkan mitra dengan gender tertentu untuk kenyamanan Anda selama layanan berlangsung.",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Obx(() {
                String saldoString = homeController.amountSaldo.value;
                int saldoInt = int.tryParse(saldoString) ?? 0;

                bool hasDiscount = packController.resultDataObject
                    .any((pack) => pack["pack_disc"] != 0);

                int normalTotal = 0;
                int total = 0;

                if (packController.category.value != "Daily Cleaning") {
                  for (var pack in packController.resultDataObject) {
                    final objects = pack["data_object"] as List? ?? [];

                    for (var obj in objects) {
                      final int amount = (obj["object_amount"] ?? 0) as int;
                      final int price = (obj["object_price"] ?? 0) as int;
                      final int normalPrice =
                          (obj["object_normal_price"] ?? 0) as int;

                      total += price * amount;
                      normalTotal += normalPrice * amount;
                    }
                  }
                }

                return Column(
                  children: [
                    packController.resultDataObject.isNotEmpty ||
                            packController.selectedPriceDuration.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub Total",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                      packController.category.value !=
                                              "Daily Cleaning"
                                          ? Utils.formatCurrency(normalTotal)
                                          : Utils.formatCurrency(int.parse(
                                              packController
                                                  .selectedDiscount.value)),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              (profileController.hasVoucher.value ||
                                      hasDiscount)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${profileController.hasVoucher.value ? "Voucher Member" : ""}"
                                          "${profileController.hasVoucher.value && hasDiscount ? " + " : ""}"
                                          "${hasDiscount ? "Promo" : ""}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                        Text(
                                            "- ${Utils.formatCurrency(normalTotal - total)}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              packController.category.value == "Daily Cleaning"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Discount",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        Text(
                                            Utils.formatCurrency(int.parse(
                                                    packController
                                                        .selectedPriceDuration
                                                        .value) -
                                                int.parse(packController
                                                    .selectedDiscount.value)),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              controller.propertyType.value == "Apartement"
                                  ? Row(
                                      children: [
                                        Text(
                                          "Biaya Layanan Apartemen",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                title: Text(
                                                  "Biaya Layanan Apartemen",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(
                                                  "Biaya ini diperlukan untuk mendukung operasional di area apartemen, seperti akses masuk, parkir petugas, dan aturan dari pihak pengelola gedung.",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      height: 1.5),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      "Oke",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.info_outline,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                        Spacer(),
                                        Text("Rp 20.000",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Biaya Platform",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text("Rp 2.000",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                      packController.category.value !=
                                              "Daily Cleaning"
                                          ? Utils.formatCurrency(total +
                                              2000 +
                                              (controller.propertyType.value ==
                                                      "Apartement"
                                                  ? 20000
                                                  : 0))
                                          : Utils.formatCurrency(int.parse(
                                                  packController
                                                      .selectedPriceDuration
                                                      .value) +
                                              2000 +
                                              (controller.propertyType.value ==
                                                      "Apartement"
                                                  ? 20000
                                                  : 0)),
                                      style: TextStyle(
                                          fontSize: 15,
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
                        child: Obx(() {
                          final enabled =
                              controller.timeText.value.isNotEmpty &&
                                  controller.dateText.value.isNotEmpty &&
                                  controller.selectedGender.value != "";
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  enabled ? Colors.blue : Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none,
                              ),
                            ),
                            onPressed: () {
                              if (controller.propertyId.value.isEmpty) {
                                SnackbarUtil.show("Alamat Kosong",
                                    "Silakan tambahkan alamat terlebih dahulu");
                                return;
                              }
                              if (controller.dateText.value.isEmpty) {
                                SnackbarUtil.show("Tanggal Layanan Kosong",
                                    "Silakan pilih tanggal layanan terlebih dahulu");
                                return;
                              }
                              if (controller.timeText.value.isEmpty) {
                                SnackbarUtil.show("Waktu Layanan Kosong",
                                    "Silakan pilih waktu layanan terlebih dahulu");
                                return;
                              }
                              try {
                                final selectedDate =
                                    DateTime.parse(controller.dateText.value);
                                final selectedTimeParts =
                                    controller.timeText.value.split(':');
                                final selectedDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  int.parse(selectedTimeParts[0]),
                                  int.parse(selectedTimeParts[1]),
                                );

                                final now = DateTime.now();

                                if (selectedDateTime.isBefore(now)) {
                                  SnackbarUtil.show(
                                    "Waktu Tidak Valid",
                                    "Waktu layanan yang dipilih sudah lewat. Silakan pilih waktu yang sesuai.",
                                  );
                                  return;
                                }
                              } catch (e) {
                                SnackbarUtil.show(
                                  "Data Tidak Valid",
                                  e.toString(),
                                );
                                return;
                              }
                              if (controller.selectedGender.value == "") {
                                SnackbarUtil.show("Gender Mitra Kosong",
                                    "Silakan pilih preferensi gender mitra yang diinginkan");
                                return;
                              }
                              if (controller.selectedPayment.value == "") {
                                SnackbarUtil.show("Pilih metode pembayaran",
                                    "Silakan pilih metode pembayaran yang diinginkan");
                                return;
                              }

                              final isDaily = packController.category.value ==
                                  "Daily Cleaning";
                              final bool isApartment =
                                  controller.propertyType.value == "Apartement";

                              final int baseFee = 2000;
                              final int apartmentFee = isApartment ? 20000 : 0;
                              final int hargaPaket = isDaily
                                  ? int.parse(packController
                                      .selectedPriceDuration.value)
                                  : total;

                              final int totalHarga =
                                  hargaPaket + baseFee + apartmentFee;

                              if (controller.selectedPayment.value == "Saldo") {
                                if (saldoInt < totalHarga) {
                                  SnackbarUtil.show(
                                    "Saldo Tidak Mencukupi",
                                    "Silakan top up saldo terlebih dahulu",
                                  );
                                  return;
                                }

                                // if (packController.category.value !=
                                //     "Daily Cleaning") {
                                //   if (saldoInt < total) {
                                //     SnackbarUtil.show("Saldo Tidak Mencukupi",
                                //         "Silakan Top up Saldo terlebih dahulu");
                                //     return;
                                //   }
                                // } else {
                                //   if (saldoInt <
                                //       int.parse(packController
                                //           .selectedPriceDuration.value)) {
                                //     SnackbarUtil.show("Saldo Tidak Mencukupi",
                                //         "Silakan top up saldo terlebih dahulu");
                                //     return;
                                //   }
                                // }

                                if (packController.category.value !=
                                    "Daily Cleaning") {
                                  Map<String, dynamic> dataPackMap =
                                      controller.getListDataPack();

                                  var dataDeep = {
                                    // "data_pack": controller.getListDataPack(),
                                    ...dataPackMap,
                                    "category": packController.category.value,
                                    "due_date": controller.dateText.value,
                                    "due_time": controller.timeText.value,
                                    "discount": "2",
                                    "order_notes":
                                        controller.noteController.text,
                                    "property_id": controller.propertyId.value,
                                    "property_city":
                                        Utils.extractSecondSentence(
                                            controller.propertyAddress.value),
                                    "mitra_gender":
                                        controller.selectedGender.value,
                                    "payment_type": "balance"
                                  };
                                  print(dataDeep);
                                  controller.confirmPayment(dataDeep);
                                } else {
                                  var dataDaily = {
                                    "data_pack[0][pack_id]":
                                packController.selectedPackageId.value,
                            "data_pack[0][pack_category]":
                                packController.category.value,
                            "data_pack[0][ph_id]":
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
                                    "payment_type": "balance"
                                  };
                                  print(dataDaily);
                                  controller.confirmPayment(dataDaily);
                                }
                              } else if (controller.selectedPayment.value ==
                                      "QRIS" ||
                                  controller.selectedPayment.value ==
                                      "Bank Transfer") {
                                Get.toNamed("/tagihan", arguments: {
                                  'metode_pembayaran':
                                      controller.selectedPayment.value,
                                  'total_harga': totalHarga
                                });
                              }
                            },
                            child: Text(
                              "Bayar Sekarang",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        })),
                  ],
                );
              }))
        ],
      ),
    );
  }

  Future<dynamic> selectAddress(
      BuildContext context, AsyncSnapshot<PropertyAddressResponse> snapshot) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Sudut membulat
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title for the dialog
                Row(
                  children: [
                    Text(
                      'Pilih Alamat',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // ListView.builder for displaying the addresses
                SizedBox(
                  height: 200,
                  // Set the height of the list view
                  child: ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedProperty.value =
                                snapshot.data!.data![index].id!.toInt();
                            controller.picName.value =
                                snapshot.data!.data![index].picName!;
                            controller.propertyAddress.value =
                                snapshot.data!.data![index].propertyAddress!;
                            controller.propertyId.value =
                                snapshot.data!.data![index].id.toString();
                            controller.propertyType.value = snapshot
                                .data!.data![index].propertyType
                                .toString();
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 5, right: 0),
                            leading: Icon(Icons.home),
                            title: Text(
                              snapshot.data!.data![index].picName!,
                              style: TextStyle(fontSize: 13),
                            ),
                            subtitle: Text(
                              snapshot.data!.data![index].propertyAddress!,
                              style: TextStyle(fontSize: 12),
                            ),
                            trailing: Radio(
                                value: snapshot.data!.data![index].id,
                                groupValue: controller.selectedProperty.value,
                                onChanged: (value) {
                                  controller.selectedProperty.value =
                                      value!.toInt();
                                  controller.picName.value =
                                      snapshot.data!.data![index].picName!;
                                  controller.propertyAddress.value = snapshot
                                      .data!.data![index].propertyAddress!;
                                  controller.propertyId.value =
                                      snapshot.data!.data![index].id.toString();
                                  controller.propertyType.value = snapshot
                                      .data!.data![index].propertyType
                                      .toString();
                                  print(controller.propertyType.value);
                                }),
                          ),
                        );
                      });
                    },
                  ),
                ),

                // Button to close the dialog
                SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Simpan")))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> voucherModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // biar tinggi menyesuaikan isi
            children: [
              const Text(
                "Voucher",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              (profileController.hasVoucher.value)
                  ? VoucherCard(
      title: "Voucher Member",
      subtitle: "Discount ${profileController.valueVoucher.value} %",
      condition: "Voucher spesial member! Gunakan di semua layanan. Ayo tingkatkan jumlah pesananmu untuk meraih voucher yang lebih besar!",
      buttonText: "Batalkan",
    ) : Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text("Tidak Ada Voucher"),
                        ],
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}

class RadioPayment extends StatelessWidget {
  RadioPayment({
    super.key,
    required this.controller,
    required this.value,
    required this.title,
    required this.icon,
  });

  final PemesananController controller;
  final String value;
  final String title;
  final IconData icon;

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String saldoString = homeController.amountSaldo.value;
      int saldoInt = int.tryParse(saldoString) ?? 0;
      return GestureDetector(
        onTap: () {
          controller.selectPayment(value);
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(
              width: 8,
            ),
            Text(title, style: TextStyle(fontSize: 14)),
            (title == "Saldo")
                ? Text(
                    " (${Utils.formatCurrency(saldoInt)})",
                    style: TextStyle(fontSize: 13, color: Colors.blue),
                  )
                : SizedBox.shrink(),
            Spacer(),
            Radio(
                value: value,
                groupValue: controller.selectedPayment.value,
                onChanged: (value) => controller.selectPayment(value!))
          ],
        ),
      );
    });
  }
}
