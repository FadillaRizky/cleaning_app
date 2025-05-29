import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          3,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectedIndex.value = index;
                              },
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: index ==
                                        controller.selectedIndex.value
                                        ? Colors.blue
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1,
                                      color: index ==
                                          controller.selectedIndex.value
                                          ? Colors.blue
                                          : Colors.black,)),
                                child: Center(
                                  child: Text(controller.status[index],
                                    style: TextStyle(color: index ==
                                        controller.selectedIndex.value
                                        ? Colors.white
                                        : Colors.black,),),
                                ),
                              ),
                            );
                          },
                        ));
                  }),
                ),
                Divider()
              ],
            ),
          )),
    );
  }
}
