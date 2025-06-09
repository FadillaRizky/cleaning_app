import 'package:cleaning_app/controller/booking.dart';
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
            builder:
                (context, AsyncSnapshot<DetailOrderResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Skeletonizer(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("asdajsdasd"),
                            Text("asdajsdasd")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("asdajsdasd"),
                            Text("asdajsdasd")
                          ],
                        )
                      ],
                    ));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No list packages found.');
              }
              final data = snapshot.data!.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nama"),
                        Text(data.picName!)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("No Handphone"),
                        Text(data.picPhone!)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tanggal"),
                        Text(Utils.formatTanggal(data.dueDate!))
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alamat"),
                        SizedBox(
                            width: 200,
                            child: Text(data.propertyAddress!,maxLines: 3,textAlign: TextAlign.end,))
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                    Text(data.category!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    (data.category != "Daily Cleaning")
                        ? Column(
                      children: data.dataPack!.map((item) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.packName!,style: TextStyle(fontWeight: FontWeight.bold),),
                            Column(
                                children: item.dataObject!.map((items){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${items.objectName}"),
                                      Text(Utils.formatCurrency(int.parse(items.objectPrice!))),
                                    ],
                                  );
                                }).toList()
                            ),
                          ],
                        );
                      }).toList(),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${data.dataPack!.first.packName} (${data.dataPack!.first.packHour} Jam)"),
                        Text(Utils.formatCurrency(data.dataPack!.first.packPrice!)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Catatan",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    TextField(
                      maxLines: 3,
                      controller: TextEditingController(text: data.orderNotes),
                      readOnly: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100]!,
                      ),
                    ),
                    SizedBox(height: 10,),
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
                        Text("PPN ${data.tax}%",style: TextStyle(color: Colors.red),),
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
              );
            }
        ),
      ),
    );
  }
}
