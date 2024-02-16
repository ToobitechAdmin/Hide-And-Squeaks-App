import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squeak/components/snakbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:squeak/view/audio_record.dart';
import 'package:squeak/view/homescreen.dart';
import 'package:squeak/view/love_audio.dart';
import 'package:squeak/view/setting.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

import 'view/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Stripe.publishableKey =
  //     'pk_test_51LKqZFGSNjIJ6i2QnlYxkoDkXMm5ClY7SPxPmd6uTCynsnTfiDItG92Brx3dR6ZbHGnBGAVtgJZ9OVXEXS1mKR0G00GrXSMXRn';
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}
