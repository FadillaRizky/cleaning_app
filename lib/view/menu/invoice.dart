import 'package:cleaning_app/model/DetailOrderResponse.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/invoice.dart';

class InvoicePage extends GetView<InvoiceController> {
  const InvoicePage({super.key});

  void _downloadInvoice(BuildContext context,Data data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text('INVOICE',
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Name: ${data.picName}'),
                  pw.Text('Mobile No: ${data.picPhone}'),
                ],
              ),
              pw.Divider(),
              pw.Text(data.category!,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              (data.category != "Daily Cleaning")
                  ? pw.Column(
                children: data.dataPack!.map((item) {
                  return pw.Column(
                      children: item.dataObject!.map((items){
                        return pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("${items.objectName}"),
                            pw.Text(Utils.formatCurrency(int.parse(items.objectPrice!))),
                          ],
                        );
                      }).toList()
                  );
                }).toList(),
              )
                  : pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("${data.dataPack!.first.packName} (${data.dataPack!.first.packHour} Jam)"),
                  pw.Text(Utils.formatCurrency(data.dataPack!.first.packPrice!)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Total Pesanan"),
                  pw.Text(Utils.formatCurrency(data.subTotal!)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Discount"),
                  pw.Text(Utils.formatCurrency(data.nominalDiscount!)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("PPN ${data.tax}%",style: pw.TextStyle(color: PdfColors.red),),
                  pw.Text(Utils.formatCurrency(data.nominalTax!)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Pembayaran',
                      style: pw.TextStyle(
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text(Utils.formatCurrency(data.grandTotal!),
                      style: pw.TextStyle(
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'INVOICE',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
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
                      final data = snapshot.data!.data;
                      return Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name:"),
                              Text(snapshot.data!.data!.picName!)
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mobile No:"),
                              Text(snapshot.data!.data!.picPhone!)
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date:"),
                              Text(Utils.formatTanggal(data!.dueDate!))
                            ],
                          ),
                          Divider(),
                          Text(data!.category!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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

                          Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(width: 0.5, color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Kembali',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _downloadInvoice(context,data),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Download Invoice',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
