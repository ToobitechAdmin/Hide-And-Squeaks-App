import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/controller/treat_Controller.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  treatController controller=Get.put(treatController());



  @override
  void initState() {
    
    super.initState();
    controller.getPolicy();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.textback), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Customhead(),
                SizedBox(height: Get.height * 0.06),
                Text(
                  "Ensuring Your Pet's \nWell-being During Play",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(height: Get.height * 0.025),
                Padding(
                  padding: EdgeInsets.only(left: 17, right: 17),
                  child:Obx(() =>controller.isLoadingpolicy.isTrue? Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)):  Text(
                   controller.para.value.toString(),
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: 1.45),
                  ),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}