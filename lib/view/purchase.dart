// import 'package:flutter/material.dart';
// import 'package:squeak/controller/treat_Controller.dart';
// import 'package:squeak/components/app_assets.dart';
// import 'package:get/get.dart';
// import 'package:squeak/components/custom.dart';
// import 'package:squeak/view/dollar.dart';
// import '../components/colors.dart';
// import '../models/treatmodel.dart';

// class PurchaseScreen extends StatefulWidget {
//   const PurchaseScreen({super.key});

//   @override
//   State<PurchaseScreen> createState() => _PurchaseScreenState();
// }

// class _PurchaseScreenState extends State<PurchaseScreen> {
//   treatController controller = Get.put(treatController());
//   bool loading = false;
//   Map<String, dynamic>? paymentIntentData;
//   @override
//   void initState() {
//     super.initState();
//     controller.fetchTreats();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: Get.height * 1,
//         width: Get.width * 1,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage(AppAssets.backgroundimage1),
//           fit: BoxFit.fill,
//           colorFilter: ColorFilter.mode(
//             AppColors.filtercolor,
//             BlendMode.srcOver,
//           ),
//         )),
//         child: Column(
//           children: [
//             Customhead(),
//             Obx(()=> controller.isLoading.value?
//               Padding(
//                 padding: EdgeInsets.only(top: 300),
//                 child: CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                 ),
//               ): Expanded(
//                 child: ListView.builder(
//                   itemCount: controller.treatList.length,
//                   itemBuilder: (context, int index) {
//                     TreatModel treat = controller.treatList[index];
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 40),
//                       child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         height: Get.height * 0.16,
//                         width: Get.width * 0.5,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             image: DecorationImage(
//                                 image: AssetImage(AppAssets.dollarback),
//                                 fit: BoxFit.fill)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CircleAvatar(
//                               radius: 47,
//                               child: Image.asset(AppAssets.treats),
//                             ),
//                             Container(
//                               height: Get.height * 0.105,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           treat.treats.toString(),
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 20,
//                                               color: Colors.black),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 7),
//                                           child: Text(
//                                             "Treats",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 20,
//                                                 color:
//                                                     AppColors.primaryColor),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                    Text(
//                                     "\$${treat.price.toString()}",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w900,
//                                         fontSize: 20,
//                                         color: Colors.black),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.to(DollarScreen(treat: treat));
//                                     },
//                                     child: Container(
//                                         height: Get.height * 0.03,
//                                         width: Get.width * 0.31,
//                                         decoration: BoxDecoration(
//                                             color: Color(0xffFF0000),
//                                             borderRadius:
//                                                 BorderRadius.circular(16)),
//                                         child: Center(
//                                           child: Text(
//                                             "Purchase",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w900,
//                                                 fontSize: 18,
//                                                 color: Colors.white),
//                                           ),
//                                         )),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//               ),
//                           )
//           ],
//         ),
//       ),
//     );
//   }
// }
