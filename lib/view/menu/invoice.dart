import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  void _downloadInvoice(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text('INVOICE', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Name: Rudi'),
                  pw.Text('Mobile No: +62 812 1234 5678'),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Transaction ID: #345678'),
                  pw.Text(''),
                ],
              ),
              pw.Divider(),
              pw.Text('DEEP CLEANING', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Bullet(text: 'Sofa dan Kursi x1 - Rp 100.000'),
              pw.Bullet(text: 'Tempat Tidur x2 - Rp 230.000'),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Pesanan'),
                  pw.Text('Rp 330.000'),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Biaya Layanan'),
                  pw.Text('Rp 2.000'),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Discount', style: pw.TextStyle(color: PdfColors.red)),
                  pw.Text('Rp 75.000', style: pw.TextStyle(color: PdfColors.red)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Pembayaran', style: pw.TextStyle(color: PdfColors.blue, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Rp 257.000', style: pw.TextStyle(color: PdfColors.blue, fontWeight: pw.FontWeight.bold)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Name:', style: TextStyle(fontSize: 14)),
                  Text('Rudi', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Mobile No:', style: TextStyle(fontSize: 14)),
                  Text('+62 812 1234 5678', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Transaction ID:', style: TextStyle(fontSize: 14)),
                  Text('#345678', style: TextStyle(fontSize: 14)),
                ],
              ),
              const Divider(height: 32),
              const Text(
                'DEEP CLEANING',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('• Sofa dan Kursi x1', style: TextStyle(fontSize: 14)),
                  Text('Rp 100.000', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('• Tempat Tidur x2', style: TextStyle(fontSize: 14)),
                  Text('Rp 230.000', style: TextStyle(fontSize: 14)),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total Pesanan', style: TextStyle(fontSize: 14)),
                  Text('Rp 330.000', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Biaya Layanan', style: TextStyle(fontSize: 14)),
                  Text('Rp 2.000', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Discount', style: TextStyle(fontSize: 14, color: Colors.red)),
                  Text('Rp 75.000', style: TextStyle(fontSize: 14, color: Colors.red)),
                ],
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                  Text('Rp 257.000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(width: 0.5,color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Kembali',style: TextStyle(color: Colors.black),),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _downloadInvoice(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Download Invoice',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
