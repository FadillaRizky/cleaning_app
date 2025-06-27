
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

