import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/card_saldo.dart';

class InfoSaldo extends StatelessWidget {
  const InfoSaldo({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardSaldo(
                    saldo: "569.000",
                    point: "1.556",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Riwayat Transaksi",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Get.offAllNamed("/menu");
                  },
                  child: Text(
                    "Kembali ke Beranda",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
