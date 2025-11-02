import 'package:cleaning_app/model/DetailOrderResponse.dart' as Data;
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/invoice.dart';

class InvoicePage extends GetView<InvoiceController> {
  const InvoicePage({super.key});

  void _downloadInvoice(BuildContext context, Data.DetailOrderData data) async {
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
                        fontSize: 58.sp, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              buildPdfInfoRow('Name', data.picName),
              buildPdfInfoRow('Mobile No', data.picPhone),
              buildPdfInfoRow('Date', Utils.formatTanggal(data.dueDate!)),
              buildPdfInfoRow('Property Type', data.propertyType),
              buildPdfInfoRow('Property Address', data.propertyAddress),
              buildPdfInfoRow('Payment Type', data.paymentType!.toUpperCase()),
              pw.Divider(),
              pw.Text(data.category!,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 32.sp)),
              pw.SizedBox(height: 5),
              (data.category != "Daily Cleaning")
                  ? pw.Column(
                      children: data.dataPack!.map((item) {
                        return pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 10),
                              pw.Text(item.packName!,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,fontSize: 32.sp)),
                              pw.Column(
                                  children: item.dataObject!.map((items) {
                                return pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                        "${items.objectName} x ${items.qty}",style: pw.TextStyle(fontSize: 32.sp)),
                                    pw.Text(Utils.formatCurrency(
                                        items.objectPrice!),style: pw.TextStyle(fontSize: 32.sp)),
                                  ],
                                );
                              }).toList())
                            ]);
                      }).toList(),
                    )
                  : pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                            "${data!.dataPack!.first.packName} (${data.dataPack!.first.packHour} Jam)",style: pw.TextStyle(fontSize: 32.sp)),
                        pw.Text(Utils.formatCurrency(
                            data.dataPack!.first.packPrice!),style: pw.TextStyle(fontSize: 32.sp)),
                      ],
                    ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Subtotal",style: pw.TextStyle(fontSize: 32.sp)),
                  pw.Text(Utils.formatCurrency(data.ttlBasicPrice!),style: pw.TextStyle(fontSize: 32.sp)),
                ],
              ),
              (data.ttlDiscPercent != 0)
                  ? pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Diskon",
                            style: pw.TextStyle(color: PdfColors.red,fontSize: 32.sp)),
                        pw.Text(Utils.formatCurrency(data.ttlDiscNominal!),
                            style: pw.TextStyle(color: PdfColors.red,fontSize: 32.sp)),
                      ],
                    )
                  : pw.SizedBox.shrink(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Biaya Platform",style: pw.TextStyle(fontSize: 32.sp)),
                  pw.Text(Utils.formatCurrency(data.platformCharge!),style: pw.TextStyle(fontSize: 32.sp)),
                ],
              ),
              (data.propertyCharge != 0)
               ? pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Apartemen Fee",style: pw.TextStyle(fontSize: 32.sp)),
                  pw.Text(Utils.formatCurrency(data.propertyCharge!),style: pw.TextStyle(fontSize: 32.sp)),
                ],
              )
              : pw.SizedBox.shrink(),
              (data.tax != 0)
                  ? pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "PPN ${data.tax}%",style: pw.TextStyle(fontSize: 32.sp)
                        ),
                        pw.Text(Utils.formatCurrency(data.nominalTax!),style: pw.TextStyle(fontSize: 32.sp)),
                      ],
                    )
                  : pw.SizedBox.shrink(),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Pembayaran',
                      style: pw.TextStyle(
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold,fontSize: 32.sp)),
                  pw.Text(Utils.formatCurrency(data.ttlSellingNominal!),
                      style: pw.TextStyle(
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold,fontSize: 32.sp)),
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
    final id = Get.arguments;
    print("id : $id");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                child: Text(
                  'INVOICE',
                  style: TextStyle(fontSize: 58.sp, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder(
                    future: controller.getDetailorder(),
                    builder: (context,
                        AsyncSnapshot<Data.DetailOrderResponse> snapshot) {
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
                              Text("Name:",style: TextStyle(fontSize: 38.sp),),
                              Text(snapshot.data!.data!.picName!,style: TextStyle(fontSize: 38.sp))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mobile No:",style: TextStyle(fontSize: 38.sp)),
                              Text(snapshot.data!.data!.picPhone!,style: TextStyle(fontSize: 38.sp))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date:",style: TextStyle(fontSize: 38.sp)),
                              Text(Utils.formatTanggal(data!.dueDate!),style: TextStyle(fontSize: 38.sp))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Property Type:",style: TextStyle(fontSize: 38.sp)),
                              Text(data.propertyType!,style: TextStyle(fontSize: 38.sp))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Property Address:",style: TextStyle(fontSize: 38.sp)),
                              Expanded(
                                child: Text(
                                  data.propertyAddress != null
                                      ? data.propertyAddress!.substring(
                                          data.propertyAddress!.indexOf(",") +
                                              2)
                                      : "-",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style:  TextStyle(color: Colors.black87,fontSize: 38.sp),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment Type:",style: TextStyle(fontSize: 38.sp)),
                              Text(data.paymentType!.toUpperCase(),style: TextStyle(fontSize: 38.sp))
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 15,),
                          Text(
                            data.category!,
                            style: TextStyle(
                                fontSize: 42.sp, fontWeight: FontWeight.bold),
                          ),
                          (data.category != "Daily Cleaning")
                              ? Column(
                                  children: data.dataPack!.map((item) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          item.packName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,fontSize: 38.sp),
                                        ),
                                        Column(
                                            children:
                                                item.dataObject!.map((items) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "${items.objectName} x ${items.qty}",style: TextStyle(fontSize: 38.sp),),
                                              Text(Utils.formatCurrency(
                                                  items.objectPrice!),style: TextStyle(fontSize: 38.sp)),
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
                                        "${data.dataPack!.first.packName} (${data.dataPack!.first.packHour} Jam)",style: TextStyle(fontSize: 38.sp)),
                                    Text(Utils.formatCurrency(
                                        data.dataPack!.first.packPrice!),style: TextStyle(fontSize: 38.sp)),
                                  ],
                                ),
                          SizedBox(
                            height: 100.h,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Subtotal"),
                              Text(Utils.formatCurrency(data.ttlBasicPrice!),style: TextStyle(fontSize: 38.sp)),
                            ],
                          ),
                          (data.ttlDiscPercent != 0)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Diskon",
                                      style: TextStyle(color: Colors.red,fontSize: 38.sp),
                                    ),
                                    Text(
                                      "- ${Utils.formatCurrency(data.ttlDiscNominal!)}",
                                      style: TextStyle(color: Colors.red,fontSize: 38.sp),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Biaya Platform",style: TextStyle(fontSize: 38.sp)),
                              Text(Utils.formatCurrency(data.platformCharge!),style: TextStyle(fontSize: 38.sp)),
                            ],
                          ),
                          (data.propertyType == "Apartement")
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Apartemen Fee",style: TextStyle(fontSize: 38.sp)),
                                    Text(Utils.formatCurrency(
                                        data.propertyCharge!),style: TextStyle(fontSize: 38.sp)),
                                  ],
                                )
                              : SizedBox.shrink(),
                          (data.tax != 0)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("PPN ${data.tax}%",style: TextStyle(fontSize: 38.sp)),
                                    Text(
                                        Utils.formatCurrency(data.nominalTax!),style: TextStyle(fontSize: 38.sp)),
                                  ],
                                )
                              : SizedBox.shrink(),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Pembayaran",style: TextStyle(fontSize: 38.sp,fontWeight: FontWeight.bold)),
                              Text(Utils.formatCurrency(
                                  data.ttlSellingNominal!),style: TextStyle(fontSize: 38.sp,fontWeight: FontWeight.bold)),
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
                                side:
                                    BorderSide(width: 0.5, color: Colors.grey),
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
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _downloadInvoice(context, data),
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

pw.Widget buildPdfInfoRow(String label, String? value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 4),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 120, // atur lebar label agar sejajar
          child: pw.Text(
            '$label',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 32.sp),
          ),
        ),
        pw.Expanded(
          child: pw.Text(":  ${value ?? '-'}",style: pw.TextStyle(fontSize: 32.sp)),
        ),
      ],
    ),
  );
}
