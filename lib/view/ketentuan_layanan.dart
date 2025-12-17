import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ketentuan Layanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Ketentuan Layanan Utilizes GO'),
            _paragraph('Terakhir diperbarui: 14 Desember 2025'),
            _paragraph(
                'Dengan menggunakan aplikasi Utilizes GO, Anda menyetujui seluruh ketentuan dan persyaratan yang tercantum di bawah ini. Utilizes GO merupakan aplikasi untuk memesan berbagai layanan yang membantu kegiatan sehari-hari.'),
            _section('1. Definisi'),
            _bullet('Aplikasi adalah aplikasi mobile Utilizes GO.'),
            _bullet(
                'Pengguna adalah pihak yang menggunakan aplikasi Utilizes GO.'),
            _bullet(
                'Mitra adalah penyedia layanan yang bekerja sama dengan Utilizes GO.'),
            _section('2. Ruang Lingkup Layanan'),
            _paragraph(
                'Utilizes GO bertindak sebagai platform penghubung antara pengguna dan mitra penyedia layanan. Utilizes GO tidak secara langsung menyediakan layanan jasa.'),
            _section('3. Akun Pengguna'),
            _bullet('Pengguna wajib memberikan data yang benar dan akurat.'),
            _bullet(
                'Keamanan akun sepenuhnya menjadi tanggung jawab pengguna.'),
            _bullet(
                'Utilizes GO berhak menonaktifkan akun yang melanggar ketentuan.'),
            _section('4. Pemesanan dan Pembayaran'),
            _bullet(
                'Harga layanan ditentukan oleh mitra dan ditampilkan di aplikasi.'),
            _bullet(
                'Pengguna wajib melakukan pembayaran sesuai metode yang tersedia.'),
            _bullet(
                'Kegagalan pembayaran dapat menyebabkan pembatalan pesanan.'),
            _section('5. Pembatalan dan Pengembalian Dana'),
            _paragraph(
                'Kebijakan pembatalan dan pengembalian dana mengikuti ketentuan masing-masing layanan dan mitra.'),
            _section('6. Hak dan Kewajiban'),
            _paragraph(
                'Utilizes GO berhak mengubah, menambah, atau mengurangi layanan demi peningkatan kualitas aplikasi.'),
            _section('7. Tanggung Jawab Layanan'),
            _paragraph(
                'Utilizes GO menjamin kualitas layanan yang dipesan melalui aplikasi sesuai dengan standar yang ditetapkan. Utilizes GO bertanggung jawab atas kerugian yang ditimbulkan akibat proses pengerjaan layanan, sepanjang kerugian tersebut terbukti berasal dari kelalaian mitra atau sistem Utilizes GO dan sesuai dengan ketentuan yang berlaku.'),
            _section('8. Kekayaan Intelektual'),
            _paragraph(
                'Seluruh konten, logo, dan merek Utilizes GO dilindungi oleh hukum dan tidak boleh digunakan tanpa izin tertulis.'),
            _section('9. Perubahan Ketentuan'),
            _paragraph(
                'Utilizes GO dapat memperbarui ketentuan layanan sewaktu-waktu. Pengguna disarankan untuk meninjau halaman ini secara berkala.'),
            _section('10. Hukum yang Berlaku'),
            _paragraph(
                'Ketentuan layanan ini diatur berdasarkan hukum Republik Indonesia.'),
            SizedBox(height: 40.h),
            Center(
              child: Text(
                'Dengan menggunakan Utilizes GO, Anda menyetujui Ketentuan Layanan ini.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.sp, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _section(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _paragraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 32.sp, height: 1.5),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 32.sp)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 32.sp, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
