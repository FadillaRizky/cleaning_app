import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/package.dart';
import '../../model/ListPackageResponse.dart';
import '../../widget/card_package.dart';

class DetailCategoryDeep extends GetView<PackageController> {
  final String id;
  final String title;
  final String img_url;
  final String description;

  DetailCategoryDeep({
    super.key,
    required this.title,
    required this.id,
    required this.img_url,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
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
                  ReadMoreText(
                    description,
                    trimLines: 10,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Read less',
                    style: TextStyle(fontSize: 15),
                    moreStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.blue),
                    lessStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: (controller.getlistPackage(title)),
                      builder: (context,
                          AsyncSnapshot<ListPackageResponse> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Skeletonizer(
                              child: Column(
                                children: [
                                  DailyCleaningCard(
                                    imgPath: '././assets/intro1.png',
                                    title: "Jasa Borongan Cleaning",
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
                            return DailyCleaningCard(
                              imgPath: snapshot.data!.data![index].packBannerPath ?? "",
                              title: snapshot.data!.data![index].packName!,
                              subtitle: snapshot.data!.data![index].packGlobalDescription!,
                              price: snapshot.data!.data![index].packPrice?.toInt() ?? 0,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static DetailCategoryDeep fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return DetailCategoryDeep(
      id: args['id'],
      title: args['title'],
      img_url: args['img_url'],
      description: args['description'],
    );
  }
}
