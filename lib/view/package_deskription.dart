import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PackageDescription extends StatelessWidget {
  const PackageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final packName = args['packName'] ?? 'Tidak ada Nama Paket';
    final packImg = args['packImg'] ?? 'Tidak ada Gambar Paket';
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
              IntrinsicHeight(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(30.r),
                        image: DecorationImage(
                          image: NetworkImage(packImg),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(30.r),
                          //     topRight: Radius.circular(30.r)),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(230, 255, 255, 255),
                              Color.fromARGB(164, 255, 255, 255), // atas
                              Color.fromARGB(
                                  96, 255, 255, 255), // transparan penuh
                            ],
                            stops: [0.0, 0.6, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(45.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            packName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(globalDesk),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h,),
              Text(
                "Detail",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(jobDesk),
              SizedBox(
                height: 10,
              ),
              Text(objectDesk),
            ],
          ),
        ),
      ),
    );
  }
}
