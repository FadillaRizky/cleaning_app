import 'package:flutter/material.dart';

class KebijakanPrivasi extends StatelessWidget {
  const KebijakanPrivasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Kebijakan Privasi Utilizes GO',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),

            SelectableText(
              '''
Adanya Kebijakan Privasi ini adalah komitmen nyata dari PT KUSUMA WIJAYA SENTOSA (selanjutnya disebut sebagai "Utilizes GO") untuk menghargai dan melindungi setiap data atau informasi pribadi Pengguna situs https://utilize-go.com/, situs-situs turunannya, dan aplikasi gawainya (selanjutnya disebut sebagai "Situs/Aplikasi"). Kebijakan Privasi ini merupakan satu kesatuan dan bagian yang tidak terpisahkan dari Syarat dan Ketentuan sebagaimana dimaksud dalam Situs/Aplikasi.

Kebijakan Privasi, Syarat dan Ketentuan, dan informasi lain yang tercantum pada Situs/Aplikasi mengatur tentang perolehan, pengumpulan, pengolahan, penganalisaan, penampilan, pembukaan dan/atau segala bentuk pengelolaan yang terkait dengan data dan/atau informasi yang Pengguna berikan kepada Utilizes GO atau data dan informasi yang Utilizes GO peroleh dari Pengguna.

Data atau informasi tersebut meliputi data pribadi Pengguna yang Utilizes GO peroleh pada saat Pengguna melakukan pendaftaran pada Situs/Aplikasi, Pengguna mengakses Situs/Aplikasi, dan Pengguna menggunakan layanan-layanan yang tersedia pada Situs/Aplikasi (selanjutnya disebut sebagai "Data").

Dengan mendaftar, mengakses, dan menggunakan layanan-layanan yang tersedia pada Situs/Aplikasi, Pengguna menyatakan dan menjamin bahwa setiap Data adalah benar dan sah, dan Pengguna dengan ini memberikan persetujuan kepada Utilizes GO untuk memperoleh, mengumpulkan, menyimpan, mengelola, dan menggunakan seluruh Data tersebut.

A. Perolehan dan Pengumpulan Data

Tujuan Utilizes GO mengumpulkan Data adalah untuk menyediakan layanan bagi Pengguna Situs/Aplikasi, termasuk namun tidak terbatas pada memproses transaksi Pengguna, mengelola dan memperlancar penggunaan Situs/Aplikasi, dan tujuan-tujuan lain yang diizinkan oleh peraturan perundang-undangan yang berlaku.

Data yang dikumpulkan oleh Utilizes GO meliputi:

1. Data yang diserahkan secara mandiri oleh Pengguna, termasuk namun tidak terbatas pada Data yang diserahkan pada saat Pengguna:
a. Membuat atau memperbaharui akun Utilizes GO, termasuk nama, alamat e-mail, nomor telepon/handphone, password, alamat, foto, atau informasi lainnya.
b. Mengunggah data diri Pengguna sehubungan dengan penyediaan layanan, termasuk foto KTP dan jenis kelamin.
c. Memberikan informasi mengenai anggota keluarga, teman, penerima manfaat, pemilik manfaat, kuasa, wali, penjamin, atau individu lainnya.
d. Menghubungi Utilizes GO melalui media Layanan Pengguna.
e. Mengisi survei yang dikirimkan oleh Utilizes GO atau pihak yang ditunjuk.
f. Mengisi data pembayaran termasuk kartu debit, kartu kredit, dan/atau dompet elektronik.
g. Menggunakan fitur yang membutuhkan izin akses perangkat atau layanan pihak ketiga.

2. Data yang terekam saat Pengguna menggunakan Situs/Aplikasi, termasuk:
a. Data lokasi aktual atau perkiraan (IP Address, Wi-Fi, geo-location).
b. Data waktu aktivitas seperti pendaftaran, login, transaksi, dan pembayaran.
c. Data preferensi dan penggunaan melalui cookies atau teknologi serupa.
d. Data perangkat seperti model, OS, bahasa, ID perangkat, jaringan.
e. Data log server seperti alamat IP, waktu akses, fitur yang digunakan.
f. Data foto dan video dari kamera dengan persetujuan Pengguna.

3. Data dari sumber lain, termasuk:
a. Mitra usaha penyedia layanan.
b. Pihak ketiga untuk login atau integrasi API.
c. Penyedia layanan pemasaran atau sumber publik.

4. Utilizes GO dapat menggabungkan Data tersebut sesuai hukum yang berlaku.

B. Penggunaan Data

Utilizes GO dapat menggunakan Data untuk:
1. Memproses transaksi dan aktivitas Pengguna.
2. Menyediakan dan meningkatkan produk dan layanan.
3. Memberikan dukungan Layanan Pengguna.
4. Menghubungi Pengguna terkait layanan dan pembayaran.
5. Penelitian, analisis, dan pengembangan sistem.
6. Informasi promosi, fitur, dan acara.
7. Investigasi aktivitas mencurigakan.
8. Penyesuaian iklan.
9. Penegakan hukum.

C. Pengungkapan Data

Utilizes GO tidak menjual atau menyewakan Data tanpa izin Pengguna kecuali:
1. Kepada mitra layanan.
2. Mitra terintegrasi API.
3. Mitra teknologi informasi.
4. Penyelesaian kendala layanan.
5. Vendor profesional dan pemasaran.
6. Media publik.
7. Afiliasi perusahaan.
8. Kewajiban hukum.

D. Cookies

Cookies digunakan untuk menyimpan preferensi Pengguna. Pengguna dapat mengatur penerimaan Cookies melalui perangkat masing-masing.

E. Akses Situs Pihak Ketiga

Utilizes GO tidak bertanggung jawab atas konten dan kebijakan privasi situs pihak ketiga.

F. Pilihan Pengguna dan Transparansi

Pengguna dapat mengatur izin, memperbarui data, dan menarik persetujuan sesuai ketentuan hukum.

G. Penyimpanan dan Penghapusan Data

Data disimpan selama akun aktif dan dihapus sesuai permintaan atau hukum.

H. Pembaharuan Kebijakan Privasi

Utilizes GO dapat memperbarui Kebijakan Privasi ini dan akan diumumkan melalui Situs/Aplikasi.

I. Kesimpulan

Utilizes GO berkomitmen melindungi privasi Pengguna dan menggunakan Data sesuai hukum yang berlaku. Pengguna disarankan untuk meninjau Kebijakan Privasi ini secara berkala.
              ''',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
