import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDescription extends StatelessWidget {
  const PackageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final packName = args['packName'] ?? 'Tidak ada Nama Paket';
    final globalDesk = args['globalDesc'] ?? 'Tidak ada deskripsi tersedia';
    final objectDesk = args['objectDesc'] ?? 'Tidak ada deskripsi tersedia';
    final jobDesk = args['jobDesc'] ?? 'Tidak ada deskripsi tersedia';
    return Scaffold(
      appBar: AppBar(
        title: Text("Deskripsi Paket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                packName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(globalDesk),
              Divider(),
              Text("Detail",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(jobDesk),
              SizedBox(height: 10,),
              Text(objectDesk),
            ],
          ),
        ),
      ),
    );
  }
}
