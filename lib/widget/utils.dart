
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
  import 'package:flutter/services.dart';

class Utils{
  static formatCurrency(num amount, {String locale = 'id_ID', String symbol = 'Rp ', int decimalDigits = 0}) {
    return NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(amount);
  }
  static String addHoursToTime(String time, String date, String hoursToAdd) {
    DateTime parsed = DateTime.parse("$date $time");
    DateTime updated = parsed.add(Duration(hours: int.parse(hoursToAdd)));
    return "${updated.hour.toString().padLeft(2, '0')}:${updated.minute.toString().padLeft(2, '0')}";
  }

  static String formatTanggal(String dateString) { ///2025-06-05 to 5 Juni 2025
    DateTime date = DateTime.parse(dateString);
    return DateFormat("d MMMM yyyy", "id_ID").format(date);
  }

  static String formatTanggal2(String isoDate) { /// "2025-06-25T17:57:18.000000Z" to "25-06-2025 17:57"
    final dateTime = DateTime.parse(isoDate);
    final formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(dateTime);
  }

  static String formatTime(String inputTime) {
    final parsedTime = DateFormat.Hms().parse(inputTime); /// "22:30:00 to 22:30
    return DateFormat.Hm().format(parsedTime);
  }

  static String extractSecondSentence(String alamat) { ///"Daerah Khusus Ibukota Jakarta, Kota Jakarta Pusat, Kecamatan Sawah Besar, Pasar Baru"; to Jakarta Pusat
    List<String> parts = alamat.split(',').map((e) => e.trim()).toList();

    if (parts.length < 2) return ''; // pastikan ada kalimat kedua

    String second = parts[1]; // kalimat ke-2
    second = second.replaceAll(RegExp(r'\b(Kota|Kabupaten)\b'), '').trim();

    return second;
  }

}



  class CurrencyInputFormatter extends TextInputFormatter {
    final NumberFormat _formatter =
    NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);

    @override
    TextEditingValue formatEditUpdate(
        TextEditingValue oldValue, TextEditingValue newValue) {
      String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

      // Jika kosong, kembalikan string kosong dan offset di 0
      if (digitsOnly.isEmpty) {
        return TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }

      final number = int.parse(digitsOnly);
      final newText = _formatter.format(number);

      return TextEditingValue(
        text: newText,
        // Posisikan kursor di akhir teks baru
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

class AppDialog {
  static Future<void> confirm({
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,

    String cancelText = "Batal",

    IconData icon = Icons.warning_rounded,

    Color iconColor = Colors.orange,
    Color confirmButtonColor = Colors.red,

    bool barrierDismissible = true,
  }) async {
    Get.dialog(
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ICON
              Container(
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(42.r),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 100.r,
                ),
              ),

              SizedBox(height: 25.h),

              /// TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),

              SizedBox(height: 24.h),

              /// MESSAGE
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 38.sp,
                ),
              ),

              SizedBox(height: 35.h),

              /// BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        padding: EdgeInsets.symmetric(vertical: 33.h),
                      ),

                      child: Text(
                        cancelText,
                        style: TextStyle(fontSize: 38.sp),
                      ),
                    ),
                  ),

                  SizedBox(width: 36.w),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmButtonColor,
                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        padding: EdgeInsets.symmetric(vertical: 33.h),
                      ),

                      child: Text(
                        confirmText,
                        style: TextStyle(fontSize: 38.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: barrierDismissible,
    );
  }
}