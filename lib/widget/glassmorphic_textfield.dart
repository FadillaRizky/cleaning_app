import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassmorphicTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const GlassmorphicTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon, this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.2),
          ],
        ),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 43.sp,
        ),
         inputFormatters: suffixIcon == null ? [
          RemoveLeadingZeroFormatter(),
          FilteringTextInputFormatter.digitsOnly,
        ] : null ,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 15, right: 10,top: 10,bottom: 10),
            child: prefixIcon,
          ),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: 36.sp,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}


class RemoveLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text;

    // Kalau cuma "0", biarkan saja
    // if (text == '0') {
    //   return newValue;
    // }

    // Hapus semua leading zero
    String newText = text.replaceFirst(RegExp(r'^0+'), '');

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
