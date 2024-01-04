import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/dumy Models/dumymodel.dart';
import 'package:squeak/components/color.dart';
import 'package:squeak/components/custom.dart';






class TestScreen extends StatefulWidget {


  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with SingleTickerProviderStateMixin {
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
        preferredSize: Size.fromHeight(77),

        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: AppBar(

            automaticallyImplyLeading: false,


            backgroundColor: Colors.black,


            bottom: TabBar(


              controller: _tabController,
              tabs: [

                Center(
                  child: Container(
                    height: Get.height*0.087555,
                    child: Center(
                      child: Tab(

                          text: 'Sound Library'),
                    ),
                  ),
                ),
                Center(child: Container(
                    height: Get.height*0.09,
                    width: Get.width*0.7,
                    child: Tab(text: 'My Library'))),

              ],
              indicator: BoxDecoration(



                // Indicator color
              ),
              labelColor: Customitems.maincolor,
              labelStyle: TextStyle(
                fontSize: 18,
                    fontWeight: FontWeight.w800,
                letterSpacing: 1.25
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.85
              ),
              unselectedLabelColor:Colors.white ,


            ),

          ),
        ),
      ),
      body: Container(


        color: Colors.black,
        child: TabBarView(
          controller: _tabController,
          children: [

            Container(
              width: Get.width*0.8,

              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: people.length,
                  itemBuilder: (Context,index){
                    AudioModel audio = people[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 13,right: 13),
                    child: Container(
                      height: Get.height*0.047,
                      width: Get.width*0.8,
                      decoration: BoxDecoration(
                        border:Border(
                          bottom: BorderSide(
                            color: Customitems.whitecolor,
                            width: 2
                          )
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          audio.play,
                          Text(audio.title,style: TextStyle(
                            color: Customitems.whitecolor,
                            fontWeight: FontWeight.w800
                          ),),
                          Text(audio.time,style: TextStyle(
                          color: Customitems.whitecolor,
                              fontWeight: FontWeight.w800
                          ),),
                          Text("${audio.treats} treats",style: TextStyle(
                          color: Customitems.maincolor,
                              fontWeight: FontWeight.w800
                          ),),
                          Icon(Icons.cloud_download_outlined,color: Customitems.whitecolor,size: 30,)

                        ],
                      )

                    ),
                  );
                  }
              ),

            ),
            Container(
              height: Get.height*0.25,
              width: Get.width*0.8,

              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: people.length,
                  itemBuilder: (Context,index){
                    AudioModel audio = people[index];
                    return Padding(
                      padding: EdgeInsets.only(left: 13,right: 13),
                      child: Container(
                          height: Get.height*0.047,
                          width: Get.width*0.8,
                          decoration: BoxDecoration(
                              border:Border(
                                  bottom: BorderSide(
                                      color: Customitems.whitecolor,
                                      width: 2
                                  )
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              audio.play,
                              Text(audio.title,style: TextStyle(
                                  color: Customitems.whitecolor,
                                  fontWeight: FontWeight.w800
                              ),),
                              SizedBox(width: Get.width*0.02,),
                              Text(audio.time,style: TextStyle(
                                  color: Customitems.whitecolor,
                                  fontWeight: FontWeight.w800
                              ),),
                              SizedBox(width: Get.width*0.1,),

                              audio.bin,

                            ],
                          )

                      ),
                    );
                  }
              ),

            ),
          ],
        ),
      ),
    );
  }
}
