import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../widget/logo_animation.dart';

/// Splash screen widget that handles initial app loading and navigation
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final RxString version = ''.obs; // Convert to reactive

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Handles all initialization tasks
  Future<void> _initializeApp() async {
    await Future.wait([
      _getVersion(),
      _navigateToNextScreen(),
    ]);
  }

  /// Fetches app version information
  Future<void> _getVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version.value = "${packageInfo.version}+${packageInfo.buildNumber}";
    } catch (e) {
      version.value = "Version unavailable";
      debugPrint('Error fetching version: $e');
    }
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final box = GetStorage();

    final bool isFirstOpen = box.read('isFirstOpen') ?? true;
    final bool isLoggedIn = box.read('token') != null;
    Get.offAllNamed(
      isFirstOpen
          ? '/intro'
          : isLoggedIn
              ? '/menu'
              : '/login',
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
               Column(
                 children: [
                   EnhancedFadeInImage(
                    imagePath: 'assets/logo.png',
                    width: screenWidth * 0.5,
                    // height: 100,
                    scaleEffect: true,
                    slideEffect: true,
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.easeIn,
                                 ),
                                  SizedBox(height: 50.h),
                         Text(
                          'SOLUSI LENGKAP DALAM SATU APLIKASI.',
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                 ],
               ),
              const Spacer(),
              Obx(() {
                return Text(
                  'Version $version',
                  style:  TextStyle(
                    fontSize: 33.sp,
                    color: Colors.black54,
                  ),
                );
              }),
               SizedBox(height: 50.h),
              
            ],
          ),
        ),
      ),
    );
  }
}
