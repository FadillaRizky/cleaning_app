import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/package.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
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
                              controller.picName.value =
                                  snapshot.data!.data!.first.picName!;
                              controller.propertyAddress.value =
                                  snapshot.data!.data!.first.propertyAddress!;
                              controller.propertyId.value =
                                  snapshot.data!.data!.first.id.toString();
                              controller.selectedProperty.value =
                                  snapshot.data!.data!.first.id!.toInt();
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
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0), // Sudut membulat
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        // Title for the dialog
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Pilih Alamat',
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),

                                                        SizedBox(height: 10),

                                                        // ListView.builder for displaying the addresses
                                                        SizedBox(
                                                          height: 200,
                                                          // Set the height of the list view
                                                          child:
                                                              ListView.builder(
                                                            itemCount: snapshot
                                                                .data!
                                                                .data!
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Obx(() {
                                                                return ListTile(
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              0),
                                                                  leading: Icon(
                                                                      Icons
                                                                          .home),
                                                                  title: Text(
                                                                    snapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .picName!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    snapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .propertyAddress!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  trailing:
                                                                      Radio(
                                                                          value: snapshot
                                                                              .data!
                                                                              .data![
                                                                                  index]
                                                                              .id,
                                                                          groupValue: controller
                                                                              .selectedProperty
                                                                              .value,
                                                                          onChanged:
                                                                              (value) {
                                                                            controller.selectedProperty.value =
                                                                                value!.toInt();
                                                                            controller.picName.value =
                                                                                snapshot.data!.data![index].picName!;
                                                                            controller.propertyAddress.value =
                                                                                snapshot.data!.data![index].propertyAddress!;
                                                                            controller.propertyId.value =
                                                                                snapshot.data!.data![index].id.toString();
                                                                          }),
                                                                );
                                                              });
                                                            },
                                                          ),
                                                        ),

                                                        // Button to close the dialog
                                                        SizedBox(height: 20),
                                                        SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .blue,
                                                                        foregroundColor:
                                                                            Colors
                                                                                .white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10))),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "Simpan")))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
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
                                          "alamat belum ditambahkan",
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Divider(),
                          Text(packController.category.value,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
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
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: packController
                                                        .resultDataObject[index]
                                                    ['pack_img'],
                                                fit: BoxFit.cover,
                                                height: 70,
                                                width: 70,
                                                placeholder: (context, url) =>
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
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  packController
                                                          .resultDataObject[
                                                      index]['pack_name'],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: packController
                                                      .resultDataObject[index]
                                                          ["data_object"]
                                                      .map<Widget>((item) {
                                                    return Text(
                                                        "\u2022 ${item['object_name']}");
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  })
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
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Catatan",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          TextField(
                            maxLines: 3,
                            controller: controller.noteController,
                            decoration: InputDecoration(
                              hintText: "Catatan (Opsional)",
                              hintStyle: TextStyle(
                                color: Colors.grey,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Pilih Waktu Layanan",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Text(
                            "Tanggal",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
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
                          Text(
                            "Waktu",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
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
                              // controller.selectTime(context);
                              Navigator.push(
                                  context,
                                  showPicker(
                                    context: context,
                                    value:
                                        Time(hour: 11, minute: 30, second: 20),
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
                                      String formattedTimeUI =
                                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                      String formattedTimeData =
                                          '${time.hour.toString().padLeft(2, '0')}:'
                                          '${time.minute.toString().padLeft(2, '0')}:00';
                                      controller.timeController.text =
                                          formattedTimeUI;
                                      controller.timeText.value =
                                          formattedTimeData;
                                    },
                                  ));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Tambahan",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
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
                                hintStyle: TextStyle(color: Colors.grey),
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
                                fontSize: 16,
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
                  int total = 0;
                  if (packController.category.value != "Daily Cleaning") {
                    for (var pack in packController.resultDataObject) {
                      final objects = pack["data_object"] as List;
                      for (var obj in objects) {
                        total += obj["object_price"] as int;
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
                                      "Saldo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue),
                                    ),
                                    Text(Utils.formatCurrency(saldoInt),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                  ],
                                ),
                                Row(
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
                                        packController.category.value !=
                                                "Daily Cleaning"
                                            ? Utils.formatCurrency(total)
                                            : Utils.formatCurrency(int.parse(
                                                packController
                                                    .selectedDiscount.value)),
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
                                packController.category.value == "Daily Cleaning"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Discount",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                              Utils.formatCurrency(int.parse(
                                                      packController
                                                          .selectedPriceDuration
                                                          .value) -
                                                  int.parse(packController
                                                      .selectedDiscount.value)),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red)),
                                        ],
                                      )
                                    : SizedBox(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                        packController.category.value !=
                                                "Daily Cleaning"
                                            ? Utils.formatCurrency(total + 2000)
                                            : Utils.formatCurrency(int.parse(
                                                    packController
                                                        .selectedPriceDuration
                                                        .value) +
                                                2000),
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
                          child: Obx(() {
                            final enabled =
                                controller.timeText.value.isNotEmpty &&
                                    controller.dateText.value.isNotEmpty &&
                                    controller.selectedGender.value != "";
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    enabled ? Colors.blue : Colors.grey,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide.none,
                                ),
                              ),
                              onPressed: () {

                                if (packController.category.value != "Daily Cleaning") {
                                  if (saldoInt < total) {
                                    SnackbarUtil.show("Saldo Tidak Mencukupi", "Silakan Top up Saldo terlebih dahulu");
                                    return ;
                                  }
                                }else{
                                  if (saldoInt < int.parse(
                                      packController
                                          .selectedPriceDuration
                                          .value)) {
                                    SnackbarUtil.show("Saldo Tidak Mencukupi", "Silakan top up saldo terlebih dahulu");
                                    return ;
                                  }
                                }
                                if (controller.dateText.value.isEmpty) {
                                  SnackbarUtil.show("Tanggal Layanan Kosong", "Silakan pilih tanggal layanan terlebih dahulu");
                                  return ;
                                }
                                if (controller.timeText.value.isEmpty) {
                                  SnackbarUtil.show("Waktu Layanan Kosong", "Silakan pilih waktu layanan terlebih dahulu");
                                  return ;
                                }
                                if (controller.selectedGender.value == "") {
                                  SnackbarUtil.show("Gender Mitra Kosong", "Silakan pilih preferensi gender mitra yang diinginkan");
                                  return ;
                                }


                                      if (packController.category.value !=
                                          "Daily Cleaning") {
                                        var dataDeep = {
                                          "data_pack":
                                          controller.getListDataPack(),
                                          "category":
                                          packController.category.value,
                                          "due_date": controller.dateText.value,
                                          "due_time": controller.timeText.value,
                                          "discount": 2,
                                          "order_notes":
                                          controller.noteController.text,
                                          "property_id": int.parse(
                                              controller.propertyId.value),
                                          "mitra_gender":
                                          controller.selectedGender.value
                                        };
                                        controller.orderPackage(dataDeep);
                                      } else {
                                        var dataDaily = {
                                          "data_pack": [
                                            {
                                              "pack_id": int.parse(packController
                                                  .selectedPackageId.value),
                                              "pack_category":
                                              packController.category.value,
                                              "pack_hour": packController
                                                  .selectedDuration.value,
                                              "object_id": [],
                                              "object_price": []
                                            }
                                          ],
                                          "category":
                                          packController.category.value,
                                          "due_date": controller.dateText.value,
                                          "due_time": controller.timeText.value,
                                          "discount": packController
                                              .selectedDiscount.value,
                                          "order_notes":
                                          controller.noteController.text,
                                          "property_id": int.parse(
                                              controller.propertyId.value),
                                          "mitra_gender":
                                          controller.selectedGender.value
                                        };
                                        controller.orderPackage(dataDaily);
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
}
