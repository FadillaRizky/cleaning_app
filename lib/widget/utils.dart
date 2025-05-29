
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

