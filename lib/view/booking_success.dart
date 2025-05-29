import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingSuccess extends StatelessWidget {
  const BookingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Spacer(),
          Center(child: SvgPicture.asset("././assets/icon/booking_success.svg",height:200,)),
          const SizedBox(height: 24),
          const Text(
            'Booking Sukses',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Silahkan tunggu konfirmasi berikutnya.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(width: 0.5,color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (){
                      Get.toNamed("/invoice");
                    }, child: Text("Lihat Invoice",style: TextStyle(color: Colors.black),)),
              ),
              SizedBox(height: 5,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: (){
                      Get.offNamed("/menu");
                    }, child: Text("Kembali ke Beranda",style: TextStyle(color: Colors.white),)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
