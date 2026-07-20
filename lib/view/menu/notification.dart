import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/model/GetNotificationResponse.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../api.dart';
import '../../controller/notification.dart';

class NotificationPage extends GetView<NotificationController> {
  final ProfileController profileController = Get.find<ProfileController>();
   NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: const PageStorageKey('NotificationScaffold'),
      appBar: AppBar(
        title: Text("Notifikasi"),
      ),
      body: 
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
        child :
        profileController.checkToken
        ? GetBuilder<NotificationController>(builder: (context) {
          return RefreshIndicator(
            onRefresh: controller.refreshNotif,
            child: FutureBuilder(
                future: controller.futureGetNotif,
                builder:
                    (context, AsyncSnapshot<GetNotificationResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Skeletonizer(
                        child: ListTile(
                      title: Text("Notification"),
                      subtitle: Text(
                          "Subtitleggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg"),
                    )); // loading state
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                    return Center(child: const Text('Belum ada notifikasi.'));
                  }
                  var data = snapshot.data!.data!.reversed.toList();
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              onTap: () async {
                                Api.updateNotification(
                                    data[index].notifId.toString());
                                Get.toNamed(
                                  "/detail-notif",
                                  arguments: {
                                    'title': data[index].title,
                                    'description': data[index].detail,
                                  },
                                )?.then((result) {
                                  if (result == true) {
                                    controller.refreshNotif();
                                  }
                                });
                              },
                              tileColor: data[index].status == "0"
                                  ? Colors.grey[300]
                                  : Colors.white,
                              title: Text(data[index].title!,style: TextStyle(fontSize: 40.sp),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].detail!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey,fontSize: 38.sp),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    Utils.formatTanggal2(data[index].createdAt!),
                                    style: TextStyle(fontSize: 30.sp,color: Colors.grey),
                                  ),
                                ],
                              ),
        
                            ),
                          ],
                        );
                      });
                }),
          );
        })
            : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Belum ada Notifikasi",
                            style: TextStyle(fontSize: 50.sp),
                          ),
                          Text(
                            "Login untuk melihat dan mengelola pesananmu",
                            style: TextStyle(fontSize: 38.sp),
                          ),
                          SizedBox(height: 30.h,),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                   style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                     Get.toNamed('/login');
                                  },
                                  child: const Text("Login"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () {
                                    Get.toNamed('/register');
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
            
            ),
      ));
  }
}
