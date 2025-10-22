import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/view/menu/profile.dart';
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

import '../../controller/menu.dart';
import '../../model/ListCategoryPackageResponse.dart';

class Home extends GetView<HomeController> {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      // key: const PageStorageKey('HomeScaffold'),
      body: SafeArea(
        child: GetBuilder<HomeController>(builder: (context) {
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
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(onTap: () async {
                          var result = await Get.toNamed("/edit-profile");
                          if (result == 'refresh') {
                            profileController.getDetailUser();
                          }
                        }, child: Obx(() {
                          return AvatarCircle(
                            imageUrl: profileController.urlAvatar.value,
                            size: 80,
                            color: Colors.grey,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() {
                                        return Text(
                                          "Selamat ${controller.getGreetingByTime()} ‘${profileController.username}’ !",
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
                                  Obx(() {
                                    return badges.Badge(
                                      badgeContent: Text(
                                        controller.notifLength.value.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      showBadge:
                                          controller.notifLength.value != 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.find<ControllerMenu>().goToTab(2);
                                          print("asdasd");
                                        },
                                        child: Icon(
                                          Icons.notifications_none,
                                          color: Colors.black,
                                          size: 26,
                                        ),
                                      ),
                                    );
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              saldoSection(
                                controller: controller,
                              )
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
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty ||
                                    textEditingValue.text == "") {
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
                                print(selected);
                                print(
                                    'Selected ID: ${selected['category_id']}');
                                Get.toNamed(
                                  '/detail-category-daily',
                                  arguments: {
                                    'id': selected['category_id'].toString(),
                                    'title': selected['category_name'] ?? "",
                                    'img_url':
                                        selected['img_url'] ?? ["", "", ""],
                                    'description':
                                        selected['description'] ?? "",
                                  },
                                );
                              },
                              fieldViewBuilder: (context, textEditingController,
                                  focusNode, onFieldSubmitted) {
                                return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Cari layanan...',
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
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                  ),
                                );
                              },
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return CarouselSlider.builder(
                            carouselController: controller.carouselController,
                            itemCount: controller.isBannerLoading.value ||
                                    controller.banner.isEmpty
                                ? 1
                                : controller.banner.length,
                            itemBuilder: (context, index, realIndex) {
                              if (controller.isLoading.value) {
                                // Loading state
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (controller.banner.isEmpty) {
                                // Empty state (placeholder)
                                return Placeholder();
                              } else {
                                // Data tersedia
                                final imageUrl = controller.banner[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Placeholder();
                                      },
                                    ),
                                  ),
                                );
                              }
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
                          );
                        }),
                        SizedBox(
                          height: 8,
                        ),
                        Obx(() {
                          return controller.banner.isEmpty
                              ? SizedBox.shrink()
                              : Container(
                                  child: Center(
                                    child: AnimatedSmoothIndicator(
                                      activeIndex:
                                          controller.currentIndex.value,
                                      count: controller.banner.length,
                                      effect: const WormEffect(
                                          dotHeight: 10, dotWidth: 10),
                                    ),
                                  ),
                                );
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "  DISCOVER SERVICES",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  // TextButton(
                                  //     onPressed: () {},
                                  //     child: const Text(
                                  //       "Hide All",
                                  //       style: TextStyle(
                                  //         decoration: TextDecoration.underline,
                                  //         decorationColor: Colors.blue,
                                  //         color: Colors.blue, // Text color
                                  //       ),
                                  //     ))
                                ],
                              ),
                              SizedBox(height: 8,),
                              FutureBuilder(
                                  future: controller.futurePackageList,
                                  builder: (context,
                                      AsyncSnapshot<ListCategoryPackageResponse>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Skeletonizer(
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4, // 3 columns
                                            childAspectRatio:
                                                1, // Adjust item height
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
                                                  decoration:
                                                      const BoxDecoration(
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis),
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
                                    controller.options.value = snapshot
                                        .data!.data!
                                        .map((e) => {
                                              'category_id': e.id ?? 0,
                                              'category_name':
                                                  e.categoryName ?? "",
                                              'img_url': [
                                                e.bannerImg1 ?? "",
                                                e.bannerImg2 ?? "",
                                                e.bannerImg3 ?? ""
                                              ],
                                              'description':
                                                  e.categoryDescription ?? "",
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
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "BEST SELLER SERVICES",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  
                                  // TextButton(
                                  //     onPressed: () {},
                                  //     child: const Text(
                                  //       "Hide All",
                                  //       style: TextStyle(
                                  //         decoration: TextDecoration.underline,
                                  //         decorationColor: Colors.blue,
                                  //         color: Colors.blue, // Text color
                                  //       ),
                                  //     ))
                                ],
                              ),
                              SizedBox(height: 8,),
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
        }),
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
                  'img_url': [
                    snapshot.data!.data![index].bannerImg1 ?? "",
                    snapshot.data!.data![index].bannerImg2 ?? "",
                    snapshot.data!.data![index].bannerImg3 ?? ""
                  ],
                  'description':
                      snapshot.data!.data![index].categoryDescription ?? "",
                },
              );
            } else {
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
    super.key,
    required this.controller,
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
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
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  );
                }

                String saldoString = controller.amountSaldo.value;
                int saldoInt = int.tryParse(saldoString) ?? 0;

                return SizedBox(
                  width: 100,
                  child: Text(
                    saldoInt != 0 ? Utils.formatCurrency(saldoInt) : "Rp. 0",
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
              child: CachedImage(
            imgUrl: imagePath,
            height: 50,
            width: 50,
            iconHeight: 40,
          )),
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
