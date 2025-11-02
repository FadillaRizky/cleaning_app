import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingSuccess extends StatelessWidget {
  const BookingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Spacer(),
          Center(
              child: SvgPicture.asset(
            "././assets/icon/booking_success.svg",
            height: MediaQuery.of(context).size.width / 2,
          )),
           SizedBox(height: 70.h),
           Text(
            'Pesanan Sukses',
            style: TextStyle(
              fontSize: 60.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
           Text(
            'Silahkan tunggu konfirmasi berikutnya.',
            style: TextStyle(
              fontSize: 40.sp,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(width: 0.5, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed("/invoice", arguments: arg);
                    },
                    child: Text(
                      "Lihat Invoice",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.offAllNamed("/menu");
                    },
                    child: Text(
                      "Kembali ke Beranda",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
