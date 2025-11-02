import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/login.dart';
import 'package:cleaning_app/view/menu/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../../controller/profile.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.username.value.isEmpty) {
      // Jika controller baru dibuat (fenix), fetch data lagi
      controller.getDetailUser();
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // warna status bar sama
        statusBarIconBrightness: Brightness.light, // ikon status bar putih
      ),
      child: Scaffold(
        // key: const PageStorageKey('ProfileScaffold'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(45.r),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/background1.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100.r),
                      bottomRight: Radius.circular(100.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black12,
                              builder: (_) => Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 10,
                                child: CircleAvatar(
                                  radius: 200.r,
                                  child: AvatarCircle(
                                    imageUrl:  controller.urlAvatar.value,
                                    size: 400.r,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: AvatarCircle(
                            imageUrl: controller.urlAvatar.value,
                            size: 220.r,
                          ),
                        );
                      }),
                      SizedBox(
                        width: 50.w,
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
                                        controller.username.value,
                                        style: TextStyle(
                                            fontSize: 55.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      );
                                    }),
                                    Text(
                                      controller.email.value,
                                      style: TextStyle(
                                          fontSize: 34.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      var result =
                                          await Get.toNamed("/edit-profile");
                                      if (result == 'refresh') {
                                        controller.getDetailUser();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 60.r,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        5), // Rounded corners
                                    child: Obx(() {
                                      return LinearProgressIndicator(
                                        value: controller.percentageData.value /
                                            100,
                                        minHeight: 10.h,
                                        backgroundColor: Colors.grey[300],
                                        // Background track color
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(Colors
                                                .black54), // Progress color
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  width: 45.w,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 1), // Border styling
                                    borderRadius: BorderRadius.circular(
                                        24.r), // Rounded corners
                                  ),
                                  child: Obx(() {
                                    return Text(
                                      "${controller.percentageData.value.toStringAsFixed(0)}%",
                                      // Display percentage
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 33.sp),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Text(
                              "Yuk lengkapi data diri kamu!",
                              style: TextStyle(
                                  fontSize: 28.sp, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // buildTileMenu(Icon(LineIcons.checkSquare, color: Colors.black,),
                //     "Berlangganan Prepaid Lebih Hemat Hingga 20%"),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 45.r, left: 45.r, right: 45.r, top: 0),
                  child: Column(
                    children: [
                      buildTileMenu(() {}, "Member Silver",
                          subtitle: "Transaksi 35x lagi untuk naik ke Gold"),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            buildCardTile(
                                () => Get.toNamed('/voucher'),
                                Icon(
                                  LineIcons.alternateTicket,
                                  color: Colors.black,
                                  size: 70.r,
                                ),
                                "Voucher",
                                "0 Voucher"),
                            SizedBox(
                              width: 10,
                            ),
                            buildCardTile(
                                () {},
                                Icon(
                                  LineIcons.userPlus,
                                  color: Colors.black,
                                  size: 70.r,
                                ),
                                "Undang Teman",
                                "0 Teman"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(50.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ],
                        ),
                        child: Column(
                          children: [
                            buildListTile(
                              title: 'Alamat',
                              icon: LineIcons.mapMarker,
                              ontap: () {
                                Get.toNamed("/alamat");
                              },
                            ),
                            buildListTile(
                              title: 'Saldo',
                              icon: LineIcons.wallet,
                              ontap: () {
                                Get.toNamed("/info-saldo");
                              },
                            ),
                            buildListTile(
                              title: 'Ketentuan Layanan',
                              icon: LineIcons.clipboardList,
                              ontap: () {},
                            ),
                            buildListTile(
                              title: 'Kebijakan Privasi',
                              icon: LineIcons.userShield,
                              ontap: () {
                                Get.toNamed("/privacy_policy");
                              },
                            ),
                            buildListTile(
                              title: 'Keluar',
                              icon: LineIcons.doorOpen,
                              ontap: () {
                                Get.find<LoginController>().logout();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardTile(
      VoidCallback ontap, Icon icon, String title, String value) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 40.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45.r),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 8)
            ], // Rounded border
            // border: Border.all(color: Colors.grey[300]!), // Light border color
          ),
          child: Column(
            children: [
              icon,
              Text(title,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 34.sp)),
              Text(value, style: TextStyle(fontSize: 28.sp)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTileMenu(VoidCallback ontap, String title, {String? subtitle}) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        alignment: Alignment(1, 1.5),
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 35.r, vertical: 35.r),
            margin: EdgeInsets.only(bottom: 30.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.r), // Rounded border
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF39B5FF), // Lighter blue at top
                  // Color(0xFF9BD8F1), // Darker blue at bottom
                  Color(0xFFB2E6FD), // Darker blue at bottom
                ],
              ),
              boxShadow: [
                // Top light shadow
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  offset: const Offset(0, -1),
                  blurRadius: 4,
                ),
                // Bottom shadow
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ], // Light border color
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 240.w,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 38.sp,
                          color: Colors.white),
                    ),
                    subtitle != null
                        ? Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                                fontSize: 25.sp, color: Colors.white),
                          )
                        : SizedBox()
                  ],
                )),
                Icon(Icons.chevron_right, color: Colors.white, size: 60.r),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 265.w,
                  width: 265.w,
                  child: Image.asset("assets/icon/icon_member.png")),
            ],
          ),
        ],
      ),
    );
  }
}

class buildListTile extends StatelessWidget {
  final Widget? trailing;
  final String title;
  final IconData icon;
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
      leading: Icon(icon,size: 65.r,),
      title: Text(title,style: TextStyle(fontSize: 42.sp),),
      trailing: trailing,
      onTap: ontap,
    );
  }
}

class AvatarCircle extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Color? color;

  const AvatarCircle({
    Key? key,
    required this.imageUrl,
    this.size = 80,
    this.color = Colors.white,
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
          errorWidget: (context, url, error) => Icon(
            Icons.person,
            size: 140.r,
            color: color,
          ),
        ),
      ),
    );
  }
}
