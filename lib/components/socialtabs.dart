import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/dumy Models/dumymodel.dart';
import 'package:squeak/dumy Models/dumymodel4.dart';
import 'package:squeak/components/color.dart';
import 'package:squeak/components/custom.dart';






class SocialTabScreen extends StatefulWidget {


  @override
  _SocialTabScreenState createState() => _SocialTabScreenState();
}

class _SocialTabScreenState extends State<SocialTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height*0.055),


        child: AppBar(

          automaticallyImplyLeading: false,
          elevation: 0.0,

          backgroundColor: Colors.transparent,




          bottom: TabBar(








            controller: _tabController,
            tabs: [

              Center(
                child: Container(

                  height: Get.height*0.05,
                  width: Get.width*0.32,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                  ),

                  child: Tab(

                      text: 'Social Feed'),
                ),
              ),
              Container(
                height: Get.height*0.052,
                width: Get.width*0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Tab(

                    text: 'Private'),
              ),

            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),




              color: Color(0xff4A330D).withOpacity(0.70) // Indicator color
            ),
            labelColor: Customitems.whitecolor,
            labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.25
            ),
            unselectedLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.85
            ),
            unselectedLabelColor:Customitems.whitecolor ,


          ),

        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 13),
        child: Container(


         color: Colors.transparent,
          child: TabBarView(
            controller: _tabController,
            children: [

              Container(
                height: Get.height*0.2,
                width: Get.width*0.1,
                child: GridView.builder(
                  // Required properties
                  itemCount: grid1.length, // Number of items to display
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2, // Number of items per row
                  ),
                  itemBuilder: (context, int index) {
                    GridModel1 social = grid1[index];
                    // Build each grid item
                    return Container(

                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(social.img),fit: BoxFit.fill)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                 Container(
                                   height: Get.height*0.022,
                                   width: Get.width*0.05,
                                   decoration: BoxDecoration(
                                     image: DecorationImage(image: AssetImage(Customitems.commentimg),fit: BoxFit.fill)
                                   ),
                                 ),
                                  SizedBox(width: Get.width*0.01,),
                                  Text(social.comment,style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                   color: Customitems.whitecolor
                                  ),)

                                ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text(social.comment,style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Customitems.whitecolor
                                    ),),
                                    SizedBox(width: Get.width*0.01,),
                                    Icon(Icons.favorite,color: Customitems.favouriteclr,),

                                  ],),


                              ],
                            ),
                            SizedBox(height: Get.height*0.11,),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(social.title,style: TextStyle(
                                color: Customitems.whitecolor,
                                fontWeight: FontWeight.w700,
                                fontSize: 17
                              ),),
                            )
                          ],
                        ),
                      ),
                    );
                  },

                ),



              ),
              Container(
                height: Get.height*0.2,
                width: Get.width*0.1,
                child: GridView.builder(
                  // Required properties
                  itemCount: grid1.length, // Number of items to display
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2, // Number of items per row
                  ),
                  itemBuilder: (context, int index) {
                    GridModel1 social = grid1[index];
                    // Build each grid item
                    return Container(

                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(social.img),fit: BoxFit.fill)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: Get.height*0.022,
                                      width: Get.width*0.05,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage(Customitems.commentimg),fit: BoxFit.fill)
                                      ),
                                    ),
                                    SizedBox(width: Get.width*0.01,),
                                    Text(social.comment,style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Customitems.whitecolor
                                    ),)

                                  ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text(social.comment,style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Customitems.whitecolor
                                    ),),
                                    SizedBox(width: Get.width*0.01,),
                                    Icon(Icons.favorite,color: Customitems.favouriteclr,),

                                  ],),


                              ],
                            ),
                            SizedBox(height: Get.height*0.11,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(social.title,style: TextStyle(
                                      color: Customitems.whitecolor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17
                                  ),),
                                ),
                                Container(
                                  height: Get.height*0.025,
                                  width: Get.width*0.037,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(Customitems.delimg),fit: BoxFit.fill)
                                  ),
                                )

                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },

                ),



              ),

            ],
          ),
        ),
      ),
    );
  }
}
