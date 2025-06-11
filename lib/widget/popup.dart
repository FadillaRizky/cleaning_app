import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  /// Show a basic custom snackbar with consistent styling.
  static void show(String title, String message) {
    Get.snackbar(
      title,
      message,
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

  /// Optional: Different styles for success, error, and warning
  static void success(String message) => show("Success", message);

  static void error(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Error",
        message,
        backgroundColor: Colors.red[500],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.all(12),
      );
    }
  }


  static void warning(String message) => Get.snackbar(
    "Warning",
    message,
    backgroundColor: Colors.orange[800],
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    borderRadius: 8,
    margin: const EdgeInsets.all(12),
  );
}
