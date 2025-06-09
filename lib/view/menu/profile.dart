import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/login.dart';
import 'package:cleaning_app/view/menu/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controller/profile.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Akun"),
      //   centerTitle: true,
      //   // actions: [
      //   //   IconButton(
      //   //     icon: Icon(Icons.favorite_border),
      //   //     onPressed: () {
      //   //       print("Search clicked");
      //   //     },
      //   //   ),
      //   //
      //   //   // Notifications Icon
      //   //   IconButton(
      //   //     icon: Icon(Icons.chat_outlined),
      //   //     onPressed: () {
      //   //       print("Notifications clicked");
      //   //     },
      //   //   ),
      //   // ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10,),
                SizedBox(
                  width: 350,
                  child: Row(
                    children: [
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black12,
                              builder: (_) =>
                                  Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 10,
                                    child: CircleAvatar(
                                      radius: 100,
                                      child: AvatarCircle(
                                        imageUrl: profileController.urlAvatar
                                            .value,
                                        size: 200,
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: AvatarCircle(
                            imageUrl: profileController.urlAvatar.value,
                            size: 80,
                          ),
                        );
                      }),
                      SizedBox(
                        width: 20,
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
                                        profileController.username.value,
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      );
                                    }),
                                    Text(
                                      "Bergabung Sejak 2025",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      var result =
                                      await Get.toNamed("/edit-profile");
                                      if (result == 'refresh') {
                                        profileController.getDetailUser();
                                      }
                                    },
                                    icon: Icon(Icons.edit, color: Colors.black))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(5), // Rounded corners
                                    child: Obx(() {
                                      return LinearProgressIndicator(
                                        value: profileController.percentageData
                                            .value / 100,
                                        minHeight: 4,
                                        backgroundColor: Colors
                                            .grey[300],
                                        // Background track color
                                        valueColor: AlwaysStoppedAnimation<
                                            Color>(
                                            Colors.black), // Progress color
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1), // Border styling
                                    borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
                                  ),
                                  child: Obx(() {
                                    return Text(
                                      "${profileController.percentageData.value
                                          .toStringAsFixed(0)}%",
                                      // Display percentage
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Text(
                              "Yuk lengkapi data diri kamu!",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildTileMenu(Icon(LineIcons.checkSquare, color: Colors.black,),
                    "Berlangganan Prepaid Lebih Hemat Hingga 20%"),
                buildTileMenu(
                    Icon(LineIcons.user, color: Colors.black,), "Member Silver",
                    subtitle: "Transaksi 35x lagi untuk naik ke Gold"),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 350,
                  child: Row(
                    children: [
                      buildCardTile(
                          Icon(LineIcons.alternateTicket, color: Colors.black,),
                          "Kupon Hadiah", "1 Voucher"),
                      SizedBox(
                        width: 10,
                      ),
                      buildCardTile(
                          Icon(LineIcons.userPlus, color: Colors.black,),
                          "Undang Teman", "0 Teman"),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ],
                  ),
                  child: Column(
                    children: [
                      // buildListTile(
                      //   title: 'Dark Mode',
                      //   icon: Icon(LineIcons.moon,),
                      //   trailing: Switch(value: false, onChanged: (value) {}),
                      //   ontap: () {},
                      // ),
                      buildListTile(
                        title: 'Alamat',
                        icon: Icon(LineIcons.mapMarker,),
                        ontap: () {
                          Get.toNamed("/alamat");
                        },
                      ),
                      buildListTile(
                        title: 'Saldo',
                        icon: Icon(LineIcons.wallet,),
                        ontap: () {
                          Get.toNamed("/info-saldo");
                        },
                      ),
                      buildListTile(
                        title: 'Hubungi Kami',
                        icon: Icon(LineIcons.phone,),
                        ontap: () {},
                      ),
                      buildListTile(
                        title: 'Ketentuan Layanan',
                        icon: Icon(LineIcons.clipboardList,),
                        ontap: () {},
                      ),
                      buildListTile(
                        title: 'Kebijakan Privasi',
                        icon: Icon(LineIcons.userShield,),
                        ontap: () {},
                      ),
                      buildListTile(
                        title: 'Keluar',
                        icon: Icon(LineIcons.doorOpen,),
                        ontap: () {
                          Get.find<LoginController>().logout();
                        },
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildCardTile(Icon icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8)
          ], // Rounded border
          // border: Border.all(color: Colors.grey[300]!), // Light border color
        ),
        child: Column(
          children: [
            icon,
            Text(title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            Text(value, style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Container buildTileMenu(Icon icon, String title, {String? subtitle}) {
    return Container(
      width: 350,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Rounded border
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5)
        ], // Light border color
      ),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8)),
              child: icon),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                  subtitle != null
                      ? Text(
                    subtitle,
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                      : SizedBox()
                ],
              )),
          Icon(Icons.chevron_right, color: Colors.black),
        ],
      ),
    );
  }
}

class buildListTile extends StatelessWidget {
  final Widget? trailing;
  final String title;
  final Icon icon;
  final VoidCallback ontap;

  const buildListTile({
    super.key,
    this.trailing,
    required this.title,
    required this.icon,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: icon,
      title: Text(title),
      trailing: trailing,
      onTap: ontap,
    );
  }
}

class AvatarCircle extends StatelessWidget {
  final String imageUrl;
  final double size;

  const AvatarCircle({
    Key? key,
    required this.imageUrl,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
          const Icon(
            Icons.person,
            size: 60,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
