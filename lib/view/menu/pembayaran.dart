import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/card_saldo.dart';

class Pembayaran extends StatelessWidget {
  const Pembayaran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembayaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CardSaldo(),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sisa Saldo U-GoWallet",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      Text("Rp. 569.000",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Pesanan",
                        style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),
                      ),
                      Text("Rp 257.000",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: (){
                    Get.toNamed("/booking-success");
                  }, child: Text("Bayar",style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}

