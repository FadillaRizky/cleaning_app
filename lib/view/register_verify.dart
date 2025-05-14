import 'package:cleaning_app/view/menu/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/register.dart';

class RegisterVerify extends GetView<RegisterController> {
  final String noHp;
  final String verificationId;

  const RegisterVerify({
    super.key,
    required this.noHp,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verifikasi OTP",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Masukkan 6-digit kode OTP yang dikirim ke nomor \n $noHp",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      controller: controller.otpControllers[index],
                      focusNode: controller.focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        counterText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          controller.focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          controller.focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.register(verificationId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50), // Rounded corners
                      ), // Shadow color
                    ),
                    child: controller.isLoadingVerify.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      'Verifikasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ),
                );
              })

              // Image.asset("assets/icon/login.png",height: 100,),
              // SizedBox(height: 15,),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text("Nomor Telepon",style: TextStyle(),),
              //     SizedBox(height: 5,),
              //     Container(
              //       decoration: BoxDecoration(border: Border.all(width: 1,),borderRadius: BorderRadius.circular(10)),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         child: Row(
              //           children: [
              //             Text("+62"),
              //             SizedBox(width: 5,),
              //             Expanded(
              //               child: TextField(
              //                 keyboardType: TextInputType.phone,
              //
              //                 decoration: InputDecoration(
              //                   prefixStyle: const TextStyle(
              //                     fontSize: 18, fontWeight: FontWeight.bold,
              //                   ),
              //                   hintText: "Masukkan nomor",
              //                   hintStyle: TextStyle(fontSize: 14),
              //                   border: InputBorder.none, // No border
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
  static RegisterVerify fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return RegisterVerify(
      noHp: args['noHp'],
      verificationId: args['verificationId'],
    );
  }

}
