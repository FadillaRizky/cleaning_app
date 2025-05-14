import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/view/menu/tambah_alamat.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/ListCategoryPackageResponse.dart';

class Home extends GetView<HomeController> {
  String selectedLocation = "Tangerang"; // Default selected value
  List<String> locations = ["Tangerang", "Jakarta", "Bandung", "Surabaya"];
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final ProfileController profileController = Get.find<ProfileController>();

  void showAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String selectedAddress =
            "Rumah"; // Example state variable for selection

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Alamat Kamu",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // Add Address Button
                TextButton.icon(
                  onPressed: () {
                    Get.to(const TambahAlamat());
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah Alamat"),
                ),

                const Divider(),

                // Address List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: Row(
                            children: [
                              const Text("Rumah",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Alamat Utama",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          subtitle: const Text(
                              "Tangerang\nJl. Cedrawasih\nTangerang, Banten\nIndonesia"),
                          trailing: Radio<String>(
                            value: "Rumah",
                            groupValue: selectedAddress,
                            onChanged: (value) {
                              selectedAddress = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      // Handle selection
                      Navigator.pop(context);
                    },
                    child: const Text("Pilih Alamat",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: RefreshIndicator(
            onRefresh: controller.refreshPackage,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(onTap: () {
                        Get.toNamed('/profile');
                      }, child: Obx(() {
                        return ClipOval(
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: CachedNetworkImage(
                              imageUrl: profileController.urlAvatar.value,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      })),
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
                          const Text("“Buat rumah Anda jadi lebih berkilau.”",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 5,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Icon(Icons.location_on, color: Colors.blue),
                          //     // Location icon
                          //     const SizedBox(width: 5),
                          //     GestureDetector(
                          //         onTap: () {
                          //           showAddressDialog(context);
                          //         },
                          //         child: const Text("Tangerang")),
                          //     const Icon(Icons.keyboard_arrow_down,
                          //         color: Colors.black)
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // )
                        ],
                      ),
                      const Icon(Icons.notifications_none)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   height: 40,
                  //   child: SearchBar(
                  //     controller: TextEditingController(),
                  //     // onChanged: controller.updateSearchQuery,
                  //     leading: const Icon(Icons.search),
                  //     elevation: const WidgetStatePropertyAll(0),
                  //     backgroundColor:
                  //         const WidgetStatePropertyAll(Color(0xfff4f4f4)),
                  //     hintText: 'Cari Layanan Kebersihan',
                  //     hintStyle: WidgetStatePropertyAll(
                  //       TextStyle(color: Colors.grey[500], fontSize: 14),
                  //     ),
                  //     shape: WidgetStatePropertyAll(
                  //       RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //           side: const BorderSide(color: Colors.black12)),
                  //     ),
                  //   ),
                  // ),
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
                      fieldViewBuilder:
                          (context, textEditingController, focusNode, onFieldSubmitted) {
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: 'Cari Layanan Kebersihan',
                            filled: true,
                            fillColor: Color(0xfff4f4f4),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black12)),
                            prefixIcon: Icon(Icons.search),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                          ),
                        );
                      },
                    )
                  ),
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
                      margin: const EdgeInsets.only(top: 10),
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "DISCOVER SERVICES",
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
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
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
          ),
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
            print(snapshot.data!.data![index].id.toString());
            Get.toNamed(
              '/detail-package',
              arguments: {
                'id': snapshot.data!.data![index].id.toString(),
                'title': snapshot.data!.data![index].categoryName ?? "",
                'img_url': snapshot.data!.data![index].categoryImage,
                'description': snapshot.data!.data![index].categoryDescription ?? "",
              },
            );
          },
          child: ServiceItem(
            name: snapshot.data!.data![index].categoryName!,
            imagePath: "assets/intro1.png",
          ),
        );
      },
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
          child: CircleAvatar(
            radius: 22, // Adjust size
            backgroundImage: AssetImage(imagePath),
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
