import 'package:cleaning_app/controller/login.dart';
import 'package:cleaning_app/main.dart';
import 'package:cleaning_app/view/login.dart';
import 'package:cleaning_app/view/register_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroductionPage extends StatelessWidget {
  void _onIntroEnd(context) {
    final storage = GetStorage();
    storage.write('isFirstOpen', false);
    Get.offAll(() => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            backgroundImage: "assets/intro1.png",
            titleWidget: Image.asset(
              "assets/icon/icon1.png",
              height: 160.w,
            ),
            bodyWidget: Column(
              children: [
                Text(
                  "Fleksibilitas dan Menyesuaikan \ndengan Kebutuhan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  "Kami menawarkan berbagai jenis layanan yang bisa disesuaikan dengan kebutuhan Anda. Layanan pembersihan harian, pembersihan umum, pembersihan setelah renovasi, dan lain-lain.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 36.sp),
                ),
              ],
            )),
        PageViewModel(
            backgroundImage: "assets/intro2.png",
            titleWidget: Image.asset(
              "assets/icon/icon2.png",
              height: 50,
            ),
            bodyWidget: Column(
              children: [
                Text(
                  "Efisiensi Waktu dan Tenaga",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  "Anda membebaskan diri dari tugas-tugas membersihkan yang memakan waktu dan tenaga. Anda bisa memanfaatkan waktu tersebut untuk hal-hal yang lebih produktif atau untuk beristirahat.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 36.sp),
                ),
              ],
            )),
        PageViewModel(
            backgroundImage: "assets/intro3.png",
            titleWidget: Image.asset(
              "assets/icon/icon3.png",
              height: 50,
            ),
            bodyWidget: Column(
              children: [
                Text(
                  "Hasil yang Lebih Profesional dan Menyeluruh",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  "Kami memiliki tenaga kerja yang terlatih, memiliki pengetahuan tentang teknik pembersihan yang efektif dan efisien, serta penggunaan produk pembersih yang tepat untuk berbagai jenis permukaan",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 36.sp),
                ),
              ],
            )),
      ],
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(color: Colors.white, fontSize: 38.sp),
      ),
      next: Icon(
        Icons.arrow_circle_right_rounded,
        color: Colors.white,
        size: 100.h,
      ),
      done:
          Text("Done", style: TextStyle(color: Colors.white, fontSize: 38.sp)),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      dotsDecorator: DotsDecorator(
        size: Size.square(23.h),
        activeSize: Size(40.w, 23.h),
        activeColor: Colors.orange,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100.r)),
        spacing: EdgeInsets.symmetric(horizontal: 8.w),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
    );
  }
}
