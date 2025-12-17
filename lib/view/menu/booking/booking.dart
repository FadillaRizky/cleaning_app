import 'package:cleaning_app/widget/auto_marquee.dart';
import 'package:cleaning_app/widget/cached_image.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cleaning_app/model/GetListOrderResponse.dart' as Data;

import '../../../controller/booking.dart';

class Booking extends GetView<BookingController> {
  const Booking({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: const PageStorageKey('BookingScaffold'),
      appBar: AppBar(
        title: Text("Booking"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: controller.getListOrder,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25.h),
                child: Obx(() {
                  return Row(
                    children: List.generate(
                      controller.status.length,
                      (index) {
                        return Expanded(
                          child: GestureDetector(
                              onTap: () {
                                controller.selectedIndex.value = index;
                                controller.selectedStatus.value =
                                    controller.status[index].toLowerCase();
                              },
                              child: Container(
                                padding: EdgeInsets.all(15.w),
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: index == controller.selectedIndex.value
                                      ? Colors.blue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: SafeMarqueeText(
                                    text: controller.status[index],
                                    maxWidth: 350.w,
                                    style: TextStyle(
                                      fontSize: 38.sp,
                                      color: index ==
                                              controller.selectedIndex.value
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    velocity: 20,
                                    pauseDuration: Duration(seconds: 3),
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                  );
                }),
              ),
              buildOrderList(),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildOrderList() {
    return Expanded(
      child: Obx(() {
        List<Data.Data> dataByStatus = controller.listOrder.where((item) {
          if (controller.selectedStatus.value == "aktif") {
            return ["open", "picked", "arrived", "progress"]
                .contains(item.orderStatus);
          } else if (controller.selectedStatus.value == "menunggu verifikasi") {
            return ["new"].contains(item.orderStatus);
          } else if (controller.selectedStatus.value == "selesai") {
            return ["finish"].contains(item.orderStatus);
          }
          return item.orderStatus == controller.selectedStatus.value;
        }).toList();
        dataByStatus.sort((a, b) {
          DateTime dateA = DateTime.parse(a.dueDate!);
          DateTime dateB = DateTime.parse(b.dueDate!);
          return dateB.compareTo(dateA); // ascending
        });

        final statusLabel = {
          "new": "Sedang diverifikasi",
          "open": "Mencari Mitra..",
          "picked": "Sedang Menuju",
          "arrived": "Sampai Lokasi",
          "progress": "Sedang Dikerjakan",
          "finish": "Selesai",
          "cancel": "Dibatalkan",
        };
        final statusColor = {
          "new": Colors.orange.shade600, // kuning untuk diverifikasi
          "open": Colors.orange.shade600, // oranye menunggu
          "picked": Colors.lightBlue.shade400, // biru muda menuju
          "arrived": Colors.blue.shade800, // biru gelap sampai
          "progress": Colors.purple.shade400, // ungu sedang dikerjakan
          "finish": Colors.green.shade400, // hijau selesai
          "cancel": Colors.red.shade400, // merah dibatalkan
        };

        if (controller.isLoading.value) {
          return Skeletonizer(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'asdasdasd',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.date_range,
                                  color: Colors.black54, size: 17),
                              SizedBox(width: 5),
                              Text(
                                "asdasdasd",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  color: Colors.black54, size: 17),
                              SizedBox(width: 5),
                              Text(
                                "asdasdasdasdasdsad",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        if (dataByStatus.isEmpty) {
          return EmptyOrder();
        }

        return ListView.builder(
          itemCount: dataByStatus.length,
          itemBuilder: (context, index) {
            final item = dataByStatus[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed("/detail-order", arguments: item.orderid)
                    ?.then((result) {
                  if (result == true) {
                    controller.getListOrder();
                  }
                });
                print(item.orderid);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r)),
                padding: EdgeInsets.all(30.r),
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedImage(
                        imgUrl: item.categoryImage ?? "",
                        height: 190.w,
                        width: 190.w,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.category!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.date_range,
                                  color: Colors.black54, size: 50.r),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  Utils.formatTanggal(item.dueDate ?? ''),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 33.sp),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  color: Colors.black54, size: 50.r),
                              const SizedBox(width: 5),
                              Text(
                                "${item.dueTime!.substring(0, 5)}",
                                style: TextStyle(fontSize: 33.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: statusColor[item.orderStatus] ?? Colors.grey,
                            borderRadius: BorderRadius.circular(60.r),
                          ),
                          child: Text(
                            statusLabel[item.orderStatus] ??
                                "Status Tidak Diketahui",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 33.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.r, vertical: 12.r),
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, size: 40.r),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Lihat Detail",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/icon/empty_order.png', // ganti dengan ilustrasi kamu
              height: 540.h,
            ),
            SizedBox(height: 90.h),

            // 📝 Judul
            Text(
              'Belum Ada Pesanan',
              style: TextStyle(
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // 📄 Deskripsi
            Text(
              'Yuk pesan sekarang untuk membuat rumahmu lebih bersih dan nyaman!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38.sp,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
