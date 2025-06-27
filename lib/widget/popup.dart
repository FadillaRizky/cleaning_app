import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SnackbarUtil {
  /// Show a basic custom snackbar with consistent styling.
  static void show(String title, String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title,
        message,
        icon: const Icon(
          LineIcons.exclamationCircle,
          size: 30,
          color: Colors.white, // tambahkan warna agar kontras
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 500),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  /// Optional: Different styles for success, error, and warning
  static void success(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Success",
        message,
        icon: const Icon(
          LineIcons.checkCircleAlt,
          size: 30,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 400),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  static void error(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Error",
        message,
        icon: const Icon(
          LineIcons.timesCircle,
          size: 30,
          color: Colors.redAccent,
        ),
        backgroundColor: Colors.red[500],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.all(12),
      );
    }
  }

  static void warning(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Warning",
        message,
        icon: const Icon(
          LineIcons.exclamationTriangle,
          size: 30,
          color: Colors.orange,
        ),
        backgroundColor: Colors.orange[800],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.all(12),
      );
    }
  }
}
