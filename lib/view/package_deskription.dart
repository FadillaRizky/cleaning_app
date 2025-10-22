import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDescription extends StatelessWidget {
  const PackageDescription({super.key});

  @override
  Widget build(BuildContext context) {
     final args = Get.arguments;
    final description = args['globalDesc'] ?? 'Tidak ada deskripsi tersedia';
    return  Scaffold(
      appBar: AppBar(
        title: Text("Deskripsi Paket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(description),
          ],
        ),
      ),
    );
  }
}
