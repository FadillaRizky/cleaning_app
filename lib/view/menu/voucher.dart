import 'package:cleaning_app/controller/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class VoucherPage extends StatelessWidget {
  VoucherPage({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  String getMemberLevel(int monthlyOrderCount) {
    if (monthlyOrderCount >= 20) return "Platinum";
    if (monthlyOrderCount >= 10) return "Gold";
    if (monthlyOrderCount >= 5) return "Silver";
    return "Basic";
  }

  // Warna sesuai level
  Color getLevelColor() {
    switch (getMemberLevel(4)) {
      case "Platinum":
        return Colors.deepPurple;
      case "Gold":
        return Colors.amber;
      case "Silver":
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final level = getMemberLevel(4);
    final color = getLevelColor();
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            (profileController.hasVoucher.value)
                ? VoucherCard(
                    title: "Voucher Member",
                    subtitle:
                        "Discount ${profileController.valueVoucher.value} %",
                    condition:
                        "Voucher spesial member! Gunakan di semua layanan. Ayo tingkatkan jumlah pesananmu untuk meraih voucher yang lebih besar!",
                    buttonText: "Batalkan",
                  )
                : Center(
                  child: Column(
                      children: [
                        Text("Belum ada Voucher.."),
                      ],
                    ),
                )
          ],
        ),
      ),
    );
  }
}

class VoucherCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String condition;
  final String buttonText;

  const VoucherCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.condition,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon kiri
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(LineIcons.alternateTicket, color: Colors.lightBlue),
            ),
            const SizedBox(width: 12),

            // Info voucher
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    condition,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
