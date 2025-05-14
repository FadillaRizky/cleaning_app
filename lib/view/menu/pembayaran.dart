import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  CardSaldo(saldo: "569.000",point: "1.556",),
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

class CardSaldo extends StatelessWidget {
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
                Text("Rp. $saldo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18)),
              ],
            ),
            Row(

              children: [
                Icon(Icons.add_circle,color: Colors.white,size: 28,),
                SizedBox(width: 10,),
                Expanded(child: Text("Top Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15))),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star,size: 18,color: Colors.yellow,),
                      SizedBox(width: 5,),
                      Text("$point points",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios,size: 18,color: Colors.blue,)
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
