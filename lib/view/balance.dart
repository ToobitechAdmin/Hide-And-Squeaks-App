import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/controller/treat_Controller.dart';

import 'package:http/http.dart' as http;
import '../components/colors.dart';
import '../components/snakbar.dart';
import '../controller/treat_Controller.dart';
import '../models/treatmodel.dart';
import 'homescreen.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  treatController controller =Get.put(treatController());
   bool loading = false;
  Map<String, dynamic>? paymentIntentData;
  @override
  void initState() {
    super.initState();
    controller.getBalance();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundmain), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Customhead(),
              SizedBox(height: Get.height * 0.080),
              Text(
                "Balance",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(height: Get.height * 0.060),
              CircleAvatar(
                radius: 77,
                child: Image.asset(AppAssets.treats),
              ),
              SizedBox(height: Get.height * 0.016),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Obx(() => controller.isLoadingbalance.value? CircularProgressIndicator(color: AppColors.primaryColor,)  :Text(
                    controller.balance.toString(),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Treats",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.15),
              Container(
                height: Get.height * 0.095,
                width: Get.width * 0.92,
                decoration: BoxDecoration(
                    color: AppColors.pinkcolor,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Song title",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                          letterSpacing: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "50 Treats",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff77838F),
                            letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.035),
              GestureDetector(
                onTap: () {
                  makePayment(widget.treat.price!.toDouble(),
                      widget.treat.id.toString());
                },
                child: Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.92,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(double amount, String treatId) async {
    try {
      setState(() {
        loading = true;
      });
      print('your Amount $amount');
      paymentIntentData = await createPaymentIntent(
        amount,
        'USD',
      );

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        setupIntentClientSecret:
            'sk_test_51LKqZFGSNjIJ6i2QWrp0oAbJqzy5bpyXZxG0JnxSHakMb1AOPCQYc19EHEzxdkfTtDbOwa79MVEof02se0vtaGs900jFR9rvMk',
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        customFlow: false,
        style: ThemeMode.light,
        customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        customerId: paymentIntentData!['customer'],
        merchantDisplayName: 'Lovelove',
      ));

      ///now finally display payment sheeet
      displayPaymentSheet(treatId);
    } catch (e, s) {
      setState(() {
        loading = false;
      });
      print('Payment exception:$e$s');
    }
  }

  createPaymentIntent(double selectAmount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(selectAmount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LKqZFGSNjIJ6i2QWrp0oAbJqzy5bpyXZxG0JnxSHakMb1AOPCQYc19EHEzxdkfTtDbOwa79MVEof02se0vtaGs900jFR9rvMk',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
      // return response.body;
    } catch (err) {
      print('Create Payment Intent Error: ${err.toString()}');
    }
  }

  displayPaymentSheet(String treatId) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        Stripe.instance.confirmPaymentSheetPayment();
        print('payment intent ID' + paymentIntentData!['id'].toString());
        print('payment intent client_secret' +
            paymentIntentData!['client_secret'].toString());
        print(
            'payment intent amount' + paymentIntentData!['amount'].toString());
        // print('payment intent' + paymentIntentData.toString());
        // orderPlaceApi(paymentIntentData!['id'].toString());
        // showLoadingDialog();
        showInSnackBar('Paid Successfully', color: Colors.green);
        controller.purchaseTreats(treatId, paymentIntentData!['id'].toString(),
            paymentIntentData!['amount'].toString());
        Get.to(() => HomeScreen());
        // hideLoadingDialog();

        paymentIntentData = null;
      }).whenComplete(() {
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      setState(() {
        loading = false;
      });
      print('Exception/DISPLAYPAYMENTSHEETS==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('$e');
    }
  }

  calculateAmount(double amount) {
    final a = ((amount) * 100).toInt();
    return a.toString();
  }
}
