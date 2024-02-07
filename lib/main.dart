import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squeak/components/snakbar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'view/splashScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LKqZFGSNjIJ6i2QnlYxkoDkXMm5ClY7SPxPmd6uTCynsnTfiDItG92Brx3dR6ZbHGnBGAVtgJZ9OVXEXS1mKR0G00GrXSMXRn';
  Stripe.merchantIdentifier = 'squeaks';

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
      home: SplashScreen(),
    );
  }
}
