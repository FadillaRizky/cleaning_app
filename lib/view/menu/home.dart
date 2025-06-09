import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/view/menu/tambah_alamat.dart';
import 'package:cleaning_app/widget/cached_image.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/ListCategoryPackageResponse.dart';

class Home extends GetView<HomeController> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final ProfileController profileController = Get.find<ProfileController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: controller.refreshPackage,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(onTap: ()async {
                            var result =
                                await Get.toNamed("/edit-profile");
                            if (result == 'refresh') {
                              profileController.getDetailUser();
                            }
                          }, child: Obx(() {
                            return ClipOval(
                              child: CachedImage(imgUrl: profileController.urlAvatar.value, height: 60, width: 60),
                            );
                          })),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Obx(() {
                                          return Text(
                                            "Selamat Pagi ‘${profileController.username}’ !",
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          );
                                        }),
                                        const Text(
                                            "“Buat rumah Anda jadi lebih berkilau.”",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.notifications_none,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                saldoSection(controller: controller,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 50,
                              child: Autocomplete<String>(
                                optionsBuilder: (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text == '') {
                                    return const Iterable<String>.empty();
                                  }
                                  return controller.options
                                      .map((e) => e['category_name'] as String)
                                      .where((String option) {
                                    return option.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase(),
                                        );
                                  });
                                },
                                onSelected: (String selection) {
                                  print('You selected: $selection');

                                  // Kalau mau dapet pack_id berdasarkan nama terpilih:
                                  var selected = controller.options.firstWhere(
                                    (e) => e['category_name'] == selection,
                                    orElse: () => {},
                                  );
                                  print('Selected ID: ${selected['id']}');
                                  Get.toNamed(
                                    '/detail-package',
                                    arguments: {
                                      'id': selected['id'].toString(),
                                      'title': selection ?? "",
                                    },
                                  );
                                },
                                fieldViewBuilder: (context, textEditingController,
                                    focusNode, onFieldSubmitted) {
                                  return TextField(
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Cari Layanan Kebersihan',
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black12)),
                                      prefixIcon: Icon(Icons.search),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                                    ),
                                  );
                                },
                              )),
                          CarouselSlider.builder(
                            carouselController: _carouselController,
                            itemCount: 2,
                            itemBuilder: (context, index, realIndex) {
                              return Image.asset("assets/promo.png");
                            },
                            options: CarouselOptions(
                              viewportFraction: 1,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                controller.currentIndex.value = index;
                              },
                            ),
                          ),
                          Obx(() {
                            return Container(
                              child: Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: controller.currentIndex.value,
                                  count: 2,
                                  effect: const WormEffect(dotHeight: 10, dotWidth: 10),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "  DISCOVER SERVICES",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Hide All",
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.blue,
                                            color: Colors.blue, // Text color
                                          ),
                                        ))
                                  ],
                                ),
                                FutureBuilder(
                                    future: controller.futurePackageList,
                                    builder: (context,
                                        AsyncSnapshot<ListCategoryPackageResponse> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Skeletonizer(
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4, // 3 columns
                                              childAspectRatio: 1, // Adjust item height
                                              crossAxisSpacing: 15,
                                              mainAxisSpacing: 15,
                                            ),
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    width: 42,
                                                    height: 42,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black12,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  const Text(
                                                    "Service",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        overflow: TextOverflow.ellipsis),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ); // loading state
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.data!.isEmpty) {
                                        return const Text('No packages found.');
                                      }
                                      controller.options.value = snapshot.data!.data!
                                          .map((e) => {
                                                'category_id': e.id ?? 0,
                                                'category_name': e.categoryName ?? "",
                                              })
                                          .toList();
                                      return gridPackageList(snapshot);
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "BEST SELLER SERVICES",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Hide All",
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.blue,
                                            color: Colors.blue, // Text color
                                          ),
                                        ))
                                  ],
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // 3 columns
                                    childAspectRatio: 1.5, // Adjust item height
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return const ServiceCard(
                                      title: "Soon",
                                      imageUrl: "assets/promo.png",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget gridPackageList(AsyncSnapshot<ListCategoryPackageResponse> snapshot) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 3 columns
        childAspectRatio: 0.8, // Adjust item height
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: snapshot.data!.data!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(snapshot.data!.data![index].categoryName);
            if (snapshot.data!.data![index].status == "active") {
              Get.toNamed(
                '/detail-category-daily',
                arguments: {
                  'id': snapshot.data!.data![index].id.toString(),
                  'title': snapshot.data!.data![index].categoryName ?? "",
                  'img_url': [snapshot.data!.data![index].bannerImg1 ?? "",snapshot.data!.data![index].bannerImg2 ?? "",snapshot.data!.data![index].bannerImg3 ?? ""],
                  'description':
                  snapshot.data!.data![index].categoryDescription ?? "",
                },
              );
            }  else{
              EasyLoading.showInfo("Coming Soon");
            }
          },
          child: ServiceItem(
            name: snapshot.data!.data![index].categoryName!,
            imagePath: snapshot.data!.data![index].categoryImage!,
          ),
        );
      },
    );
  }
}

class saldoSection extends StatelessWidget {
  final HomeController controller;
  const saldoSection({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Get.toNamed("/info-saldo");
                },
                child: SvgPicture.asset(
                  '././assets/icon/icon_wallet.svg',
                  height: 18,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return SizedBox(
                    height: 13,
                    width: 13,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  );
                }

                String saldoString = controller.amountSaldo.value;
                int saldoInt = int.tryParse(saldoString) ?? 0;

                return SizedBox(
                  width: 100,
                  child: Text(
                    saldoInt != 0
                    ? Utils.formatCurrency(saldoInt)
                    : "Rp. -",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Get.toNamed('/isi-saldo');
                  },
                  child: Icon(
                    Icons.add_circle,
                    size: 22,
                  )),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 22,
                color: Colors.yellow,
              ),
              Text("1500 Point", style: TextStyle(color: Colors.white))
            ],
          )
        ],
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final String name;
  final String imagePath;

  const ServiceItem({required this.name, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2), // Padding for border effect
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue, width: 2), // Blue border
          ),
          child: ClipOval(
            child: CachedImage(imgUrl: imagePath, height: 50, width: 50, iconHeight: 40,)
          ),
        ),

        const SizedBox(height: 5),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ServiceCard({required this.title, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 300,
      // height: 110,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Rounded corners
        child: Stack(
          children: [
            // Background Image with proper size
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl), // Load image
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Gradient Overlay (using Positioned.fill for full coverage)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
            ),

            // Text Overlay (ensure it appears on top)
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      // fontSize: 18, // Ensuring visibility
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Favorite Icon (Top Right)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
