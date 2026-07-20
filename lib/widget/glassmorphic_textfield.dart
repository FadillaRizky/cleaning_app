import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class GlassmorphicTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;        // ← tambahan
  final FocusNode? nextFocusNode;

  const GlassmorphicTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.focusNode,                  // ← tambahan
    this.nextFocusNode,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
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
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: inputType,
          focusNode: focusNode,
          textInputAction: nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          onEditingComplete: () {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          style: TextStyle(
            color: Colors.black87,
            fontSize: 43.sp,
          ),
          inputFormatters: suffixIcon == null
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 20.w),
                    child: prefixIcon,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.black54,
              fontSize: 36.sp,
            ),
            border: InputBorder.none,
            isCollapsed: true,
          ),
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

KeyboardActionsConfig buildKeyboardActionsConfig(
  BuildContext context, {
  required List<({FocusNode focusNode, FocusNode? nextFocusNode})> fields,
}) {
  return KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
    keyboardBarColor: const Color(0xFFD1D5DB),
    nextFocus: false,
    actions: fields
        .map(
          (f) => KeyboardActionsItem(
            focusNode: f.focusNode,
            toolbarButtons: [
              // ── Tombol Kembali (kiri) ──────────────────────────────
              (node) => GestureDetector(
                    onTap: () {
                     node.unfocus(); 
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.chevron_left,
                            color: Color(0xFF007AFF),
                            size: 20,
                          ),
                          Text(
                            'Tutup',
                            style: const TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

              // ── Spacer ─────────────────────────────────────────────
              (_) => const Spacer(),

              // ── Tombol Lanjut / Selesai (kanan) ───────────────────
              (node) => GestureDetector(
                    onTap: () {
                      if (f.nextFocusNode != null) {
                        FocusScope.of(context).requestFocus(f.nextFocusNode);
                      } else {
                        node.unfocus();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            f.nextFocusNode != null ? 'Lanjut' : 'Selesai',
                            style: const TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (f.nextFocusNode != null)
                            const Icon(
                              Icons.chevron_right,
                              color: Color(0xFF007AFF),
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        )
        .toList(),
  );
}