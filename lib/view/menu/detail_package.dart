import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/ListPackageResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/package.dart';
import '../../widget/card_package.dart';

class DetailPackage extends GetView<PackageController> {
  final String id;
  final String title;
  final String img_url;
  final String description;

  DetailPackage({
    super.key,
    required this.title,
    required this.id,
    required this.img_url,
    required this.description,
  });

  var titleList = [
    "Jasa Borongan Cleaning",
    "Daily Cleaning Tanpa Alat",
    "Daily Cleaning Dengan Alat",
    "Kombo Daily Cleaning + Pembersih Dapur (Dengan Alat)",
  ];

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: img_url,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                size: 60,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: (controller.getlistPackage()),
                      builder: (context,
                          AsyncSnapshot<ListPackageResponse> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Skeletonizer(
                              child: Column(
                            children: [
                                CleaningCard(
                                imgPath: '././assets/intro1.png',
                                title: titleList[0],
                                subtitle:
                                "Tersedia pilihan jasa cleaning berdasarkan luas area, jumlah tenaga kerja, waktu pengerjaan atau jenis acara/kegiatan.",
                                ontap: () {

                                }, price: 0,
                              ),
                            ],
                          ));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return const Text('No list packages found.');
                        }
                        return ListView.builder(
                          shrinkWrap: true, // ✅ important
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (Buildcontext, index) {
                            return CleaningCard(
                              imgPath: snapshot.data!.data![index].packBannerPath ?? "",
                              title: snapshot.data!.data![index].packName!,
                              subtitle: snapshot.data!.data![index].packGlobalDescription!,
                              price: snapshot.data!.data![index].packPrice!.toInt(),
                              ontap: () {
                                print("id detail package ${snapshot.data!.data![index].packId!.toString()}");
                                Get.toNamed(
                                  '/detail-daily',
                                  arguments: {
                                    'id': snapshot.data!.data![index].packId!.toString(),
                                    'title': snapshot.data!.data![index].packName!,
                                  },
                                );
                              },
                            );
                          },
                        );
                      }),

                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   leading: Radio(
                  //       value: true,
                  //       groupValue: () {},
                  //       onChanged: (t) {}),
                  //   title: Text("Dengan Alat"),
                  //   subtitle: Text(
                  //       "Peralatan dan perlengkapan untuk pembersihan dibawa oleh mitra."),
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   leading: Radio(
                  //       value: true,
                  //       groupValue: () {},
                  //       onChanged: (t) {}),
                  //   title: Text("Tanpa Alat"),
                  //   subtitle: Text(
                  //       "Peralatan dan perlengkapan untuk pembersihan hunian umum disediakan oleh pelanggan."),
                  // ),
                  // Divider(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text("Durasi Pengerjaan",style: TextStyle(
                  //     fontSize: 20, fontWeight: FontWeight.bold)),

                  // SizedBox(
                  //   height: 100,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(15),
                  //     child: Container(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Row(
                  //         children: [
                  //           ClipRRect(
                  //             borderRadius: BorderRadius.circular(8),
                  //             child: Image.asset(
                  //               "././assets/intro1.png",
                  //               height: 100,
                  //               width: 100, // fix width untuk gambar
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //           const SizedBox(width: 8), // jarak antara gambar dan teks
                  //           Expanded(
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "Ruang Tamu",
                  //                   style: const TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 8),
                  //                 Container(
                  //                   decoration: BoxDecoration(
                  //                     border: Border.all(color: Colors.grey.shade400),
                  //                     borderRadius: BorderRadius.circular(6),
                  //                   ),
                  //                   child: Row(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       buildButton("-", () {
                  //                         // logic decrement
                  //                       }),
                  //                       buildDivider(),
                  //                       Padding(
                  //                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  //                         child: Text(
                  //                           '1',
                  //                           style: const TextStyle(fontSize: 16),
                  //                         ),
                  //                       ),
                  //                       buildDivider(),
                  //                       buildButton("+", () {
                  //                         // logic increment
                  //                       }),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
      // FutureBuilder(
      //     future: controller.getDetailPackage(id),
      //     builder: (context, AsyncSnapshot<DetailPackageResponse> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Skeletonizer(
      //             child: Column(
      //           children: [
      //             SizedBox(
      //               height: 100,
      //               width: double.infinity,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      //               child: Column(
      //                 children: [
      //                   Text("Daily Cleaning"),
      //                   Text(
      //                       "Layanan kebersihan rutin yang dilakukan setiap hari untuk menjaga kebersihan dan kerapian sebuah hunian. Tujuannya adalah untuk mencegah penumpukan kotoran, debu, dan sampah, serta menciptakan lingkungan yang bersih, sehat, dan nyaman."),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         )); // loading state
      //       } else if (snapshot.hasError) {
      //         return Text('Error: ${snapshot.error}');
      //       } else if (!snapshot.hasData) {
      //         return const Text('No detail packages found.');
      //       }
      //       return SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             CachedNetworkImage(
      //               imageUrl: snapshot.data!.data!.pack!.packBannerPath!,
      //               fit: BoxFit.cover,
      //               placeholder: (context, url) =>
      //                   const CircularProgressIndicator(),
      //               errorWidget: (context, url, error) => const Icon(
      //                 Icons.person,
      //                 size: 60,
      //                 color: Colors.grey,
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     snapshot.data!.data!.pack!.packName!,
      //                     style: TextStyle(
      //                         fontSize: 20, fontWeight: FontWeight.bold),
      //                   ),
      //                   Text(
      //                     snapshot
      //                         .data!.data!.pack!.packObjectDescription!,
      //                     style: TextStyle(fontWeight: FontWeight.w500),
      //                   ),
      //                   SizedBox(height: 10,),
      //                   ListView.builder(
      //                     shrinkWrap: true, // ✅ important
      //                     physics: NeverScrollableScrollPhysics(),
      //                     itemCount: titleList.length,
      //                     itemBuilder: (Buildcontext, index){
      //                       return CleaningCard(
      //                         imgPath: '././assets/intro1.png',
      //                         title: titleList[index],
      //                         subtitle:
      //                         "Tersedia pilihan jasa cleaning berdasarkan luas area, jumlah tenaga kerja, waktu pengerjaan atau jenis acara/kegiatan.",
      //                         ontap: () {
      //                           Get.toNamed('/detail-daily',arguments: {
      //                             'title': titleList[index],
      //                           },);
      //                         },
      //                       );
      //                     },
      //                   ),
      //
      //
      //                   // ListTile(
      //                   //   contentPadding: EdgeInsets.zero,
      //                   //   leading: Radio(
      //                   //       value: true,
      //                   //       groupValue: () {},
      //                   //       onChanged: (t) {}),
      //                   //   title: Text("Dengan Alat"),
      //                   //   subtitle: Text(
      //                   //       "Peralatan dan perlengkapan untuk pembersihan dibawa oleh mitra."),
      //                   // ),
      //                   // ListTile(
      //                   //   contentPadding: EdgeInsets.zero,
      //                   //   leading: Radio(
      //                   //       value: true,
      //                   //       groupValue: () {},
      //                   //       onChanged: (t) {}),
      //                   //   title: Text("Tanpa Alat"),
      //                   //   subtitle: Text(
      //                   //       "Peralatan dan perlengkapan untuk pembersihan hunian umum disediakan oleh pelanggan."),
      //                   // ),
      //                   // Divider(),
      //                   // SizedBox(
      //                   //   height: 10,
      //                   // ),
      //                   // Text("Durasi Pengerjaan",style: TextStyle(
      //                   //     fontSize: 20, fontWeight: FontWeight.bold)),
      //
      //
      //                   // SizedBox(
      //                   //   height: 100,
      //                   //   child: ClipRRect(
      //                   //     borderRadius: BorderRadius.circular(15),
      //                   //     child: Container(
      //                   //       padding: const EdgeInsets.all(8.0),
      //                   //       child: Row(
      //                   //         children: [
      //                   //           ClipRRect(
      //                   //             borderRadius: BorderRadius.circular(8),
      //                   //             child: Image.asset(
      //                   //               "././assets/intro1.png",
      //                   //               height: 100,
      //                   //               width: 100, // fix width untuk gambar
      //                   //               fit: BoxFit.cover,
      //                   //             ),
      //                   //           ),
      //                   //           const SizedBox(width: 8), // jarak antara gambar dan teks
      //                   //           Expanded(
      //                   //             child: Column(
      //                   //               mainAxisAlignment: MainAxisAlignment.center,
      //                   //               crossAxisAlignment: CrossAxisAlignment.start,
      //                   //               children: [
      //                   //                 Text(
      //                   //                   "Ruang Tamu",
      //                   //                   style: const TextStyle(
      //                   //                     fontSize: 16,
      //                   //                     fontWeight: FontWeight.bold,
      //                   //                   ),
      //                   //                 ),
      //                   //                 const SizedBox(height: 8),
      //                   //                 Container(
      //                   //                   decoration: BoxDecoration(
      //                   //                     border: Border.all(color: Colors.grey.shade400),
      //                   //                     borderRadius: BorderRadius.circular(6),
      //                   //                   ),
      //                   //                   child: Row(
      //                   //                     mainAxisSize: MainAxisSize.min,
      //                   //                     children: [
      //                   //                       buildButton("-", () {
      //                   //                         // logic decrement
      //                   //                       }),
      //                   //                       buildDivider(),
      //                   //                       Padding(
      //                   //                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      //                   //                         child: Text(
      //                   //                           '1',
      //                   //                           style: const TextStyle(fontSize: 16),
      //                   //                         ),
      //                   //                       ),
      //                   //                       buildDivider(),
      //                   //                       buildButton("+", () {
      //                   //                         // logic increment
      //                   //                       }),
      //                   //                     ],
      //                   //                   ),
      //                   //                 ),
      //                   //               ],
      //                   //             ),
      //                   //           ),
      //                   //         ],
      //                   //       ),
      //                   //     ),
      //                   //   ),
      //                   // )
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       );
      //     }),
    );
  }

  static DetailPackage fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return DetailPackage(
      id: args['id'],
      title: args['title'],
      img_url: args['img_url'],
      description: args['description'],
    );
  }
}
