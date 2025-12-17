import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LevelMemberPage extends StatelessWidget {
  LevelMemberPage(
      {super.key, required this.currentLevel, required this.currentDiscount});

  // 👉 Contoh data user (nanti bisa dari API / Controller)
  final String currentLevel;
  final int currentDiscount;

  final List<Color> basicGradient = [
    Color(0xFF3E3E3E), // dark grey
    Color(0xFF7A7A7A), // grey
    Color(0xFFBDBDBD), // light grey
  ];

  final List<Color> silverGradient = [
    Color(0xFF5F5F5F), // grey metal
    Color(0xFF9E9E9E), // silver
    Color(0xFFE0E0E0), // light silver
  ];

  final List<Color> goldGradient = [
    Color(0xFFB8860B), // dark gold
    Color(0xFFFFD54F), // gold
    Color(0xFFFFF8E1), // light gold
  ];

  final List<Color> platinumGradient = [
    Color(0xFF1E3C72), // deep blue
    Color(0xFF4FACFE), // platinum blue
    Color(0xFFE3F2FD), // ice silver
  ];

  List<Color> getLevelGradient(String level) {
  switch (level.toLowerCase()) {
    case 'silver':
      return silverGradient;

    case 'gold':
      return goldGradient;

    case 'platinum':
      return platinumGradient;

    case 'basic':
    default:
      return basicGradient;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level Member'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(35.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== LEVEL USER SAAT INI =====
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(35.r),
              decoration: BoxDecoration(
                gradient:  LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: getLevelGradient(currentLevel),
                ),
                borderRadius: BorderRadius.circular(35.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level Anda Saat Ini',
                    style: TextStyle(
                        fontSize: 38.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                          height: 100.h,
                          child: Image.asset(
                              'assets/icon/level-${currentLevel.toLowerCase()}.png')),
                      const SizedBox(width: 8),
                      Text(
                        currentLevel,
                        style: TextStyle(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Diskon aktif hingga $currentDiscount%',
                    style: TextStyle(fontSize: 36.sp, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

             Text(
              'Daftar Level Member Utilizes GO',
              style: TextStyle(
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
             Text(
              'Semakin sering Anda melakukan transaksi atau pemesanan layanan, '
              'semakin tinggi level member yang Anda dapatkan dan semakin besar diskon yang bisa dinikmati.',
              style: TextStyle(fontSize: 38.sp),
            ),
            const SizedBox(height: 20),

            _levelCard(
              title: 'Basic',
              color: Colors.grey,
              discount: '2%',
              description:
                  'Level awal untuk semua pengguna baru tanpa potongan harga.',
              isActive: currentLevel == 'Basic',
            ),

            _levelCard(
              title: 'Silver',
              color: Colors.blueGrey,
              discount: '3%',
              description:
                  'Minimal 5 transaksi untuk mendapatkan diskon hingga 5%.',
              isActive: currentLevel == 'Silver',
            ),

            _levelCard(
              title: 'Gold',
              color: Colors.amber,
              discount: '5%',
              description:
                  'Minimal 15 transaksi untuk menikmati diskon hingga 10%.',
              isActive: currentLevel == 'Gold',
            ),

            _levelCard(
              title: 'Platinum',
              color: Colors.deepPurple,
              discount: '10%',
              description:
                  'Minimal 30 transaksi untuk mendapatkan diskon maksimal 15%.',
              isActive: currentLevel == 'Platinum',
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child:  Text(
                'Catatan:\n'
                '• Level member meningkat otomatis sesuai jumlah transaksi.\n'
                '• Diskon diterapkan langsung saat pemesanan.\n'
                '• Ketentuan level dapat berubah sewaktu-waktu.',
                style: TextStyle(fontSize: 36.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static LevelMemberPage fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return LevelMemberPage(
      currentLevel: args['current_level'],
      currentDiscount: args['current_discount'],
    );
  }

  Widget _levelCard({
    required String title,
    required Color color,
    required String discount,
    required String description,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: color, width: 1.5) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 150.h,
              child:
                  Image.asset('assets/icon/level-${title.toLowerCase()}.png')),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 42.sp,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Text(
                          'Aktif',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Diskon hingga $discount',
                  style:  TextStyle(
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style:  TextStyle(fontSize: 36.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
