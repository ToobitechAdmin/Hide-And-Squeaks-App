import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/components/custom_appbar.dart';
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
       backgroundColor: Colors.black,
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        color: Colors.black,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(AppAssets.textback), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(),
                SizedBox(height: Get.height * 0.06),
                const Text(
                  "Ensuring Your Pet's \nWell-being During Play",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white ),
                ),
                SizedBox(height: Get.height * 0.025),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child:Obx(() =>controller.isLoadingpolicy.isTrue? Padding(padding: EdgeInsets.only(top: Get.height*0.23),   child: Center(child: Text("Ensurance Policy.......",style: TextStyle(color: AppColors.primaryColor,fontSize: 25),))):  Text(
                   controller.para.value.toString(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color:AppColors.whitecolor,
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
