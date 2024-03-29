import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/dumy Models/dumymodel3.dart';
import 'package:squeak/components/color.dart';
import 'package:squeak/components/custom.dart';


class TreatScreen6 extends StatefulWidget {
  final TreatModel treat;
  const TreatScreen6({required this.treat});

  @override
  State<TreatScreen6> createState() => _TreatScreen6State();
}

class _TreatScreen6State extends State<TreatScreen6> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height*1,
          width: Get.width*1,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Customitems.backgroundmain)
                  ,fit:BoxFit.fill)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height*0.03),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Customhead()
                ),
                SizedBox(height: Get.height*0.080),
               Text("Balance",style:TextStyle(
                 fontSize: 35,
                 fontWeight: FontWeight.w600,
                 color: Colors.white
               ),),
                SizedBox(height: Get.height*0.060),

              CircleAvatar(
                radius: 77,
                child: Image.asset(Customitems.treats),
              ),
                SizedBox(height: Get.height*0.016),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.treat.treats,style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text("Treats",style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Customitems.maincolor
                      ),),
                    )
                  ],
                ),
                SizedBox(height: Get.height*0.15),

                Container(
                  height: Get.height*0.095,
                  width: Get.width*0.92,
                  decoration: BoxDecoration(
                    color: Customitems.pinkcolor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Song title",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color:Customitems.maincolor,
                        letterSpacing: 1
                      ),),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text("50 Treats",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:Color(0xff77838F),
                          letterSpacing: 1
                        ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.035),
                Container(
                  height: Get.height*0.06,
                  width: Get.width*0.92,
                  decoration: BoxDecoration(
                    color: Customitems.maincolor,
                    borderRadius: BorderRadius.circular(5)
                  ),

                  child: Center(
                    child: Text("Confirm",style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,

                    ),),
                  ),

                ),
              ],
            ),
          ),

        ),

      ),
    );
  }
}