import 'package:cleaning_app/controller/booking.dart';
import 'package:cleaning_app/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../model/DetailOrderResponse.dart';
import '../../widget/utils.dart';

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
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Nama"), Text(data.picName!)],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("No Handphone"),
                              Text(data.picPhone!)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tanggal"),
                              Text(Utils.formatTanggal(data.dueDate!))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Alamat"),
                              SizedBox(
                                  width: 200,
                                  child: Text(
                                    data.propertyAddress!,
                                    maxLines: 3,
                                    textAlign: TextAlign.end,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          Text(
                            data.category!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Column(
                                            children:
                                                item.dataObject!.map((items) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${items.objectName}"),
                                              Text(Utils.formatCurrency(
                                                  int.parse(
                                                      items.objectPrice!))),
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Catatan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            maxLines: 3,
                            controller:
                                TextEditingController(text: data.orderNotes),
                            readOnly: true,
                            decoration: InputDecoration(
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
                              filled: true,
                              fillColor: Colors.grey[100]!,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Pesanan"),
                              Text(Utils.formatCurrency(data.subTotal!)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discount"),
                              Text(Utils.formatCurrency(data.nominalDiscount!)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PPN ${data.tax}%",
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(Utils.formatCurrency(data.nominalTax!)),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Pembayaran"),
                              Text(Utils.formatCurrency(data.grandTotal!)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          // var data = {
                          //   "pic_name": controller.nameController.text,
                          //   "pic_phone":,
                          // };
                          // controller.cancelOrder(data);
                          showCancelDialog(context,data.orderid!.toInt());
                        },
                        child: Text("Batalkan Pesanan")),
                  )
                ],
              );
            }),
      ),
    );
  }

  void showCancelDialog(
      BuildContext context, int id) {
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
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      const Text('Konfirmasi Pembatalan',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15),
                      const Text("Silakan isi alasan pembatalan:"),
                      const SizedBox(height: 10),
                      TextField(
                        controller: reasonController,
                        maxLines: 3,
                        decoration:  InputDecoration(
                          hintText: "Tulis alasan...",
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    SizedBox(height: 8,),
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
                                  border: Border.all(color: Colors.grey)
                                ),
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
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                              ),
                              onPressed: () =>
                                  Navigator.of(context).pop(), // Close dialog
                              child: const Text('Batal'),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                              ),
                              onPressed: () {
                                final reason = reasonController.text.trim();
                                if (reason.isEmpty) {
                                  SnackbarUtil.show("Field Kosong", "Alasan tidak boleh kosong");
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
        //   AlertDialog(
        //   title: const Text('Konfirmasi Pembatalan'),
        //   content: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       const Text("Silakan isi alasan pembatalan:"),
        //       const SizedBox(height: 10),
        //       TextField(
        //         controller: reasonController,
        //         maxLines: 3,
        //         decoration: const InputDecoration(
        //           hintText: "Tulis alasan...",
        //           border: OutlineInputBorder(),
        //         ),
        //       ),
        //     ],
        //   ),
        //   actions: [
        //     Expanded(
        //       child: TextButton(
        //         onPressed: () => Navigator.of(context).pop(), // Close dialog
        //         child: const Text('Batal'),
        //       ),
        //     ),
        //     Expanded(
        //       child: ElevatedButton(
        //         style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        //         onPressed: () {
        //           final reason = reasonController.text.trim();
        //           if (reason.isEmpty) {
        //             ScaffoldMessenger.of(context).showSnackBar(
        //               const SnackBar(content: Text("Alasan tidak boleh kosong")),
        //             );
        //           } else {
        //             Navigator.of(context).pop(); // Close dialog
        //             onSubmit(reason); // Pass the reason back
        //           }
        //         },
        //         child: const Text('Kirim'),
        //       ),
        //     ),
        //   ],
        // );
      },
    );
  }
}
