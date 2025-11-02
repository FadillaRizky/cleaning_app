import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/widget/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class DailyCleaningCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final dynamic discPercent;
  // final int price;
  final String subtitle;
  final VoidCallback ontap;

  const DailyCleaningCard(
      {Key? key,
      required this.imgPath,
      required this.title,
      required this.subtitle,
      required this.ontap,
      required this.discPercent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.r),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(35.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // warna bayangan lembut
            spreadRadius: 2, // seberapa jauh bayangan menyebar
            blurRadius: 10, // seberapa lembut bayangan
            offset: const Offset(0, 4), // posisi bayangan (x, y)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28.r),
                    child: CachedImage(
                      imgUrl: imgPath,
                      height: 190.w,
                      width: 190.w,
                    ),
                  ),
                  if (discPercent != 0.0)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          "PROMO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 35.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45.sp,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: ontap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  'Pilih',
                  style: TextStyle(fontSize: 35.sp),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
