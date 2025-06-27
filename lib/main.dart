import 'package:cleaning_app/controller/home.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/view/booking_success.dart';
import 'package:cleaning_app/view/info_saldo.dart';
import 'package:cleaning_app/view/introduction.dart';
import 'package:cleaning_app/view/isi_saldo.dart';
import 'package:cleaning_app/view/kebijakan_privasi.dart';
import 'package:cleaning_app/view/login.dart';
import 'package:cleaning_app/view/menu.dart';
import 'package:cleaning_app/view/menu/detail_daily_cleaning.dart';
import 'package:cleaning_app/view/menu/detail_category.dart';
import 'package:cleaning_app/view/menu/detail_notif.dart';
import 'package:cleaning_app/view/menu/editprofile.dart';
import 'package:cleaning_app/view/menu/home.dart';
import 'package:cleaning_app/view/menu/invoice.dart';
import 'package:cleaning_app/view/menu/order_detail.dart';
import 'package:cleaning_app/view/menu/pembayaran.dart';
import 'package:cleaning_app/view/menu/pemesanan.dart';
import 'package:cleaning_app/view/menu/profile.dart';
import 'package:cleaning_app/view/menu/tambah_alamat.dart';
import 'package:cleaning_app/view/register.dart';
import 'package:cleaning_app/view/register_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'bindings.dart';
import 'controller/login.dart';
import 'controller/register.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'view/menu/detail_category_deep.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("init");
  final storage = GetStorage();
  final isFirstOpen = storage.read('isFirstOpen') ?? true;
  final token = storage.read('token');
  final isLoggedIn = token != null;
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    isFirstOpen: isFirstOpen,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isFirstOpen;

  const MyApp({super.key, required this.isLoggedIn, required this.isFirstOpen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 1920),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBindings(),
          builder: EasyLoading.init(),
          title: 'Cleaning App',
          locale: const Locale('id', 'ID'), // Set default locale to Indonesian
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('id', 'ID'),
          ],
          localizationsDelegates:  const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          fallbackLocale: const Locale('en', 'US'),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            scaffoldBackgroundColor: Colors.grey[100],
            appBarTheme: AppBarTheme(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white,),
            fontFamily: 'Poppins',
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              // ... other styles
            ),
          ),
          initialRoute: isFirstOpen
              ? '/intro'
              : isLoggedIn
                  ? '/menu'
                  : '/login',
          getPages: [
            GetPage(name: '/intro', page: () => IntroductionPage()),
            GetPage(
                name: '/login',
                page: () => LoginPage(),
                binding: InitialBindings()),
            GetPage(
                name: '/register',
                page: () => const RegisterPage(),
                binding: RegisterBindings()),
            GetPage(
              name: '/register-verify',
              page: () => RegisterVerify.fromArguments(),
            ),
            GetPage(
                name: '/profile',
                page: () => ProfilePage(),
                binding: ProfileBindings()),
            GetPage(name: '/edit-profile', page: () => EditProfile()),
            GetPage(
              name: '/menu',
              page: () => const Menu(),
              binding: HomeBindings(),
            ),
            GetPage(
              name: '/detail-category-daily',
              page: () =>  DetailCategory.fromArguments(),
              binding: DetailPackageBindings(),
            ),
            // GetPage(
            //   name: '/detail-category-deep',
            //   page: () =>  DetailCategoryDeep.fromArguments(),
            //   binding: DetailPackageBindings(),
            // ),
            GetPage(
              name: '/detail-daily',
              page: () =>  DetailDailyCleaning.fromArguments(),
              binding: DetailDailyBindings(),
            ),
            GetPage(
              name: '/pemesanan',
              page: () =>  Pemesanan(),
              binding: PemesananBindings()
            ),
            GetPage(
              name: '/pembayaran',
              page: () =>  Pembayaran(),
            ),
            GetPage(
              name: '/booking-success',
              page: () =>  BookingSuccess(),
            ),
            GetPage(
              name: '/invoice',
              page: () =>  InvoicePage(),
              binding: InvoiceBindings()
            ),
            GetPage(
              name: '/isi-saldo',
              page: () =>  IsiSaldo(),
            ),
            GetPage(
              name: '/upload-bukti-topup',
              page: () =>  UploadBuktiTopup(),
            ),
            GetPage(
              name: '/topup-success',
              page: () =>  TopupSuccess(),
            ),
            GetPage(
              name: '/info-saldo',
              page: () =>  InfoSaldo(),
            ),
            GetPage(
              name: '/alamat',
              page: () =>  DaftarAlamat(),
              binding: AlamatBindings()
            ),
            GetPage(
                name: '/tambah-alamat',
                page: () =>  TambahAlamat(),
                binding: AlamatBindings()
            ),
            GetPage(
                name: '/pilih-provinsi',
                page: () =>  SelectProvince(),
                binding: AlamatBindings()
            ),
            GetPage(
                name: '/detail-order',
                page: () =>  OrderDetail(),
            ),
            GetPage(
              name: '/detail-notif',
              page: () =>  DetailNotif.fromArguments(),
            ),
            GetPage(
              name: '/privacy_policy',
              page: () =>  KebijakanPrivasi(),
            ),
          ],
        );
      }
    );
  }
}
