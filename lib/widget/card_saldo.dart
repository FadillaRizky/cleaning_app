import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CardSaldo extends GetView<HomeController> {
  final String saldo;
  final String point;
  const CardSaldo({
    super.key, required this.saldo, required this.point,
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
              15), // optional, kalau mau ada sudut melengkung
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('././assets/icon_saldo.png',height: 21,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Saldo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),),
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                        height: 13,
                        width: 13,
                        child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,));
                  }
                  return Text(
                    Utils.formatCurrency(int.parse(controller.amountSaldo.value)),
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),
                  );
                }),
                // Text("Rp. $saldo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18)),
              ],
            ),
            Row(

              children: [
                GestureDetector(
                    onTap: (){
                      Get.toNamed("/isi-saldo");
                    },
                    child: Icon(Icons.add_circle,color: Colors.white,size: 28,)),
                SizedBox(width: 10,),
                Expanded(child: Text("Top Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15))),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Row(
                //     children: [
                //       Icon(Icons.star,size: 18,color: Colors.yellow,),
                //       SizedBox(width: 5,),
                //       Text("$point points",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),),
                //       SizedBox(width: 10,),
                //       Icon(Icons.arrow_forward_ios,size: 18,color: Colors.blue,)
                //     ],
                //   ),
                // )
              ],
            )
          ],
        ));
  }
}