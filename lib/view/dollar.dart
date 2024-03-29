import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/color.dart';
import 'package:squeak/view/text.dart';


class DollarScreen extends StatefulWidget {
  const DollarScreen({super.key});

  @override
  State<DollarScreen> createState() => _DollarScreenState();
}

class _DollarScreenState extends State<DollarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height*1,
          width: Get.width*1,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Customitems.backgroundimage1),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Color(0xff01090C).withOpacity(0.95) ,// Adjust opacity as needed
                  BlendMode.srcOver,


                ),
              )
          ),
          child: Column(
            children: [
              SizedBox(height: Get.height*0.045),
              Container(
                height: Get.height*0.09,
                width: Get.width*0.30,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(Customitems.signin),fit: BoxFit.fill)
                ),
              ),
              SizedBox(height: Get.height*0.15),
              GestureDetector(
                onTap: (){
                  Get.to(TextScreen());
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(Customitems.dollar),
                  radius: 100,

                ),
              ),
              SizedBox(height: Get.height*0.055),
              Container(
                child: Container(
                  height: Get.height*0.17,
                  width: Get.width*0.83,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: AssetImage(Customitems.dollarback),
                    fit: BoxFit.fill)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 47,
                        child: Image.asset(Customitems.treats),
                      ),

                      Container(
                        height: Get.height*0.115,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment:Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text("100",style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.black
                                  ),),
                                  Padding(
                                    padding: EdgeInsets.only(left: 7),
                                    child: Text("Coins",style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      color: Customitems.maincolor
                                    ),),
                                  )
                                ],
                              ),
                            ),
                            Text("\$20",style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Colors.black
                            ),),
                            Container(
                              height: Get.height*0.0355,
                              width: Get.width*0.31,
                              decoration: BoxDecoration(
                                color: Color(0xffFF0000),
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Center(
                                child: Text("Purchase",style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: Colors.white
                                ),),
                              )
                            )
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
