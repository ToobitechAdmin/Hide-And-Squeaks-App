// import 'package:flutter/material.dart';
// import 'package:squeak/models/dumymodel5.dart';
// import 'package:squeak/components/app_assets.dart';
// import 'package:get/get.dart';
// import 'package:squeak/components/custom.dart';

// import '../components/colors.dart';

// class AppStoreScreen extends StatefulWidget {
//   const AppStoreScreen({super.key});

//   @override
//   State<AppStoreScreen> createState() => _AppStoreScreenState();
// }

// class _AppStoreScreenState extends State<AppStoreScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       height: Get.height * 1,
//       width: Get.width * 1,
//       decoration: BoxDecoration(
//           image: DecorationImage(
//         image: AssetImage(AppAssets.menuback),
//         fit: BoxFit.fill,
//         colorFilter: ColorFilter.mode(
//           AppColors.filtercolor, // Adjust opacity as needed
//           BlendMode.srcOver,
//         ),
//       )),
//       child: Column(
//         children: [
//           Customhead(),
//           SizedBox(
//             height: Get.height * 0.02,
//           ),
//           Container(
//             height: Get.height * 0.055,
//             width: Get.width * 0.95,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(AppAssets.appstoreimg),
//                     fit: BoxFit.fill)),
//             child: Center(
//                 child: Padding(
//               padding: EdgeInsets.only(top: 10),
//               child: Text(
//                 "In App Store",
//                 style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w800),
//               ),
//             )),
//           ),
//           Expanded(
//             child: Container(
//               height: Get.height * 0.7,
//               width: Get.width * 0.75,
//               child: GridView.builder(
//                 // Required properties
//                 itemCount: app.length, // Number of items to display
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 0,
//                     crossAxisCount: 2,
//                     childAspectRatio: 3 / 4 // Number of items per row
//                     ),
//                 itemBuilder: (context, int index) {
//                   AppModel item = app[index];
//                   // Build each grid item
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: Get.height * 0.165,
//                         width: Get.width * 0.36,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage(item.img), fit: BoxFit.fill)),
//                       ),
//                       Container(
//                         height: Get.height * 0.026,
//                         child: Text(
//                           item.title,
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.whitecolor),
//                         ),
//                       ),
//                       Container(
//                         height: Get.height * 0.025,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.star,
//                                   color: AppColors.primaryColor,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: AppColors.primaryColor,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: AppColors.primaryColor,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: AppColors.primaryColor,
//                                   size: 20,
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               item.price,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.whitecolor),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
