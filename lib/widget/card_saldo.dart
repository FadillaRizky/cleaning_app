import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class CardSaldo extends GetView<HomeController> {
  const CardSaldo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 170,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('././assets/saldo.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(
              40.r), // optional, kalau mau ada sudut melengkung
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('././assets/icon_saldo.png',height: 60.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Saldo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 43.sp),),
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                        height: 38.w,
                        width: 38.w,
                        child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,));
                  }
                  return Text(
                    Utils.formatCurrency(int.parse(controller.amountSaldo.value)),
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 50.sp),
                  );
                }),
                // Text("Rp. $saldo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18)),
              ],
            ),
            GestureDetector(
               onTap: (){
                      Get.toNamed("/isi-saldo");
                    },
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle,color: Colors.white,size: 65.r,),
                  SizedBox(width: 10,),
                  Text("Top Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 40.sp)),
                ],
              ),
            )
          ],
        ));
  }
}