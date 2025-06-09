import 'package:cleaning_app/widget/cached_image.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cleaning_app/model/GetListOrderResponse.dart' as Data;

import '../../controller/booking.dart';

class Booking extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: controller.getListOrder,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        controller.status.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              controller.selectedIndex.value = index;
                              controller.selectedStatus.value =
                                  controller.status[index].toLowerCase();
                            },
                            child: Container(
                              width: 100,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: index == controller.selectedIndex.value
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                // border: Border.all(
                                //   width: 1,
                                //   color: index == controller.selectedIndex.value
                                //       ? Colors.blue
                                //       : Colors.black,
                                // ),
                              ),
                              child: Center(
                                child: Text(
                                  controller.status[index],
                                  style: TextStyle(
                                    color: index == controller.selectedIndex.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
              Expanded(
                child: Obx(() {
                  List<Data.Data> dataByStatus = controller.listOrder
                      .where((item) =>
                  item.orderStatus == controller.selectedStatus.value)
                      .toList();
                  dataByStatus.sort((a, b) {
                    DateTime dateA = DateTime.parse(a.dueDate!);
                    DateTime dateB = DateTime.parse(b.dueDate!);
                    return dateB.compareTo(dateA); // ascending
                  });

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

                  return ListView.builder(
                    itemCount: dataByStatus.length,
                    itemBuilder: (context, index) {
                      final item = dataByStatus[index];
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed("/detail-order",arguments: item.orderid);
                          print(item.orderid);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedImage(
                                  imgUrl: item.packBannerPath ?? "",
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                     item.packCategory == "Deep Cleaning"
                                         ?
                                    item.packCategory!
                                     : item.packName!,
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
                                        Utils.formatTanggal(item.dueDate ?? ''),
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
                                        "${item.dueTime!.substring(0, 5)} - ${Utils.addHoursToTime(item.dueTime!, item.dueDate!, item.packHour!)}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
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
              )
            ],
          ),
        ),
      )),
    );
  }
}
