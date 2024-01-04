import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/color.dart';





class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _profilekey = GlobalKey<FormState>();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _breedController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height*1,
        width: Get.width*1,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Customitems.backgroundmain),fit: BoxFit.fill)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*0.015,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   width: Get.width*0.035,
                   decoration: BoxDecoration(
                       border: Border(
                           bottom: BorderSide(
                               color: Customitems.whitecolor,
                               width: 2
                           )
                       )
                   ),

                 ),
                 SizedBox(width: Get.width*0.02,),
                 Container(
                   width: Get.width*0.15,
                   decoration: BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         color: Customitems.whitecolor,
                         width: 2
                       )
                     )
                   ),

                 ),
                 SizedBox(width: Get.width*0.02,),
                 Container(
                   width: Get.width*0.035,
                   decoration: BoxDecoration(
                       border: Border(
                           bottom: BorderSide(
                               color: Customitems.whitecolor,
                               width: 2
                           )
                       )
                   ),

                 ),
                 SizedBox(width: Get.width*0.02,),
                 Text("Profile",style: TextStyle(
                   fontSize: 30,
                   color: Customitems.maincolor,
                   fontWeight:FontWeight.w800
                 ),),
                 SizedBox(width: Get.width*0.02,),
                 Container(
                   width: Get.width*0.035,
                   decoration: BoxDecoration(
                       border: Border(
                           bottom: BorderSide(
                               color: Customitems.whitecolor,
                               width: 2
                           )
                       )
                   ),

                 ),
                 SizedBox(width: Get.width*0.02,),
                 Container(
                   width: Get.width*0.15,
                   decoration: BoxDecoration(
                       border: Border(
                           bottom: BorderSide(
                               color: Customitems.whitecolor,
                               width: 2
                           )
                       )
                   ),

                 ),
                 SizedBox(width: Get.width*0.02,),
                 Container(
                   width: Get.width*0.035,
                   decoration: BoxDecoration(
                       border: Border(
                           bottom: BorderSide(
                               color: Customitems.whitecolor,
                               width: 2
                           )
                       )
                   ),

                 ),
               ],
             ),
              SizedBox(height: Get.height*0.02,),
              Container(height: Get.height*0.082,
                width: Get.width*0.85,
                decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(32),
                  color:Customitems.containerclr
                ),
                child: Center(
                  child: Text("Pete",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 40
                  ),),
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              Container(
                width: Get.width*0.75,
                height: Get.height*0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Customitems.whitecolor,
                            width: 2
                          )
                        )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    Container(
                      height: Get.height*0.025,
                      width: Get.width*0.001,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Customitems.whitecolor,
                                  width: 2
                              )
                          )
                      ),
                    ),



                  ],
                ),
              ),
              SizedBox(height: Get.height*0.01,),
              Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(Customitems.back1),
                      radius: 140,
                      child: CircleAvatar(
                        radius: 138,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(Customitems.back2),
                        child: Padding(
                          padding: EdgeInsets.only(left:150,top: 80),
                          child: GestureDetector(
                            onTap: (){

                            },
                              child: Image.asset(Customitems.back3)),
                        ),
                      ),

                    ),
                  ),
                  Image.asset(Customitems.back4)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Column(


                  children: [
                    Align(
                      alignment:Alignment.topLeft,
                      child: Text("Name",style: TextStyle(
                        color: Customitems.maincolor,
                        fontSize: 21,
                        fontWeight: FontWeight.w500
                      ),),
                    ),
                    SizedBox(height: Get.height*0.003,),
                    Container(height: Get.height*0.15,
                      width: Get.width*0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color:Customitems.containerclr
                      ),
                      child: Column(




                        children: [
                          SizedBox(height: Get.height*0.018,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Name",style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900
                              ),),
                              SizedBox(width: Get.width*0.02,),
                              TextFormField(
                                controller: _nameController,

                                textAlign: TextAlign.start,
                                cursorColor: Customitems.maincolor,
                                style: TextStyle(
                                  color: Customitems.maincolor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.do_not_disturb_on_rounded,color: Customitems.maincolor,size: 8,),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Customitems.maincolor,width: 3)
                                  ),

                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Customitems.maincolor,width: 3), // Change color as needed
                                    ),
                                    focusColor: Colors.transparent,
                                    hintStyle: TextStyle(
                                      fontSize: 17,
                                      color: Customitems.maincolor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    constraints: BoxConstraints.tightFor(width: Get.width*0.55,height: Get.height*0.035)
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: Get.height*0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text("Bred",style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w900,

                                ),),
                              ),
                              SizedBox(width: Get.width*0.05,),
                              TextField(
                                controller: _breedController,
                                textAlign: TextAlign.start,
                                cursorColor: Customitems.maincolor,
                                style: TextStyle(
                                  color: Customitems.maincolor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700

                                ),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.do_not_disturb_on_rounded,color: Customitems.maincolor,size: 8,),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Customitems.maincolor,width: 3)
                                    ),

                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Customitems.maincolor,width: 3), // Change color as needed
                                    ),
                                    focusColor: Colors.transparent,
                                    hintStyle: TextStyle(
                                      fontSize: 17,
                                      color: Customitems.maincolor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    constraints: BoxConstraints.tightFor(width: Get.width*0.55,height: Get.height*0.035)
                                ),
                              ),


                            ],
                          ),
                          Spacer()
                        ],
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.03,),
              Container(
                height: Get.height*0.1,
                width: Get.width*0.85,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(Customitems.pet),fit: BoxFit.fill)
                ),
              ),
              SizedBox(height: Get.height*0.03,),
              Container(
                height: Get.height*0.068,
                width: Get.width*0.41,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Customitems.save),fit: BoxFit.fill)
                ),
                child: Center(
                  child: Text("Save",style: TextStyle(
                    fontSize: 30,
                    color: Customitems.whitecolor,
                    fontWeight: FontWeight.w700
                  ),),
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}
