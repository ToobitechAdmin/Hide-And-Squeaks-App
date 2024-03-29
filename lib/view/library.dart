import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/color.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/view/dollar.dart';
import 'package:squeak/components/test.dart';
import 'package:squeak/view/menu.dart';
import 'package:squeak/view/purchase.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height * 1,
          width: Get.width * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Customitems.backgroundmain),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [

          Padding(
          padding: EdgeInsets.only(left: 25,right: 25,top:30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(PurchaseScreen());
                },
                child: Container(
                  height: Get.height*0.069,
                  width: Get.width*0.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Customitems.heart),fit: BoxFit.fill)
                  ),

                ),
              ),
              Container(
                height: Get.height*0.085,
                width: Get.width*0.29,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(Customitems.signin),fit: BoxFit.fill)
                ),
              ),

              GestureDetector(
                onTap: (){
                  Get.to(MenuScreen());
                },
                child: Container(
                    height: Get.height*0.08,
                    width: Get.width*0.12,
                    child: Icon(Icons.menu_rounded,color: Customitems.maincolor,size: 50,)),
              )
            ],
          ),
        ),
              SizedBox(height: Get.height * 0.02),
              GestureDetector(
                onTap: () {
                  Get.to(DollarScreen());
                },
                child: CustomPlay(),
              ),
              SizedBox(height: Get.height * 0.025),
              Expanded(
                child: Container(
                  height: Get.height * 0.25,
                  width: Get.width * 0.92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                      child: TestScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
