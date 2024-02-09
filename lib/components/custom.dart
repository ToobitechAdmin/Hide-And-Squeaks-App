import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';
// import 'package:squeak/models/dumymodel5.dart';
import 'package:squeak/view/purchase.dart';
import 'package:squeak/view/menu.dart';
import 'colors.dart';

class Customhead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 55),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Get.to(PurchaseScreen());
            },
            child: Container(
              height: Get.height * 0.069,
              width: Get.width * 0.15,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.heart), fit: BoxFit.fill)),
            ),
          ),
          Container(
            height: Get.height * 0.085,
            width: Get.width * 0.29,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.signin), fit: BoxFit.fill)),
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(MenuScreen());
            },
            child: Container(
                height: Get.height * 0.08,
                width: Get.width * 0.12,
                child: Icon(
                  Icons.menu_rounded,
                  color: AppColors.primaryColor,
                  size: 50,
                )),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String fieldname;

  CustomButton({required this.fieldname});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.067,
      width: Get.width * 0.9,
      color: AppColors.primaryColor,
      child: Center(
        child: Text(
          fieldname,
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.whitecolor),
        ),
      ),
    );
  }
}

class CustomSettings extends StatelessWidget {
  final String library;
  final String settingimage;

  CustomSettings({required this.library, required this.settingimage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(settingimage),
            radius: 50,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: Get.height * 0.012),
          Text(
            library,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                height: 1,
                color: AppColors.whitecolor,
                fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}

// final List<AudioModel> people = [
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   AudioModel(
//       audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
//       title: "Song Title",
//       time: '3:21',
//       treats: 20,
//       download: Icon(
//         Icons.download,
//         color: Customitems.whitecolor,
//       ),
//       bin: Icon(Icons.delete_sharp, color: Customitems.whitecolor)),
//   // Add more people as needed
// ];

class CustomBar extends StatelessWidget {
  final String midtext;

  CustomBar({
    required this.midtext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Get.to(PurchaseScreen());
            },
            child: Container(
              height: Get.height * 0.069,
              width: Get.width * 0.15,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(AppAssets.heart), fit: BoxFit.fill)),
            ),
          ),
          Text(
            midtext,
            style: TextStyle(
                fontSize: 30,
                color: AppColors.whitecolor,
                fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: () {
              Get.to(MenuScreen());
            },
            child: Container(
                height: Get.height * 0.08,
                width: Get.width * 0.12,
                child: Icon(
                  Icons.menu_rounded,
                  color: AppColors.primaryColor,
                  size: 50,
                )),
          )
        ],
      ),
    );
  }
}

// final List<CommentModel> share = [
//   CommentModel(
//       username: "Syed Omer",
//       time: "20 Days ago",
//       comment: "Lorem Ipsum is a dumy text",
//       img: "assets/images/profile1.jpg"),
//   CommentModel(
//       username: "Syed Omer",
//       time: "20 Days ago",
//       comment: "Lorem Ipsum is a dumy text",
//       img: "assets/images/profile1.jpg"),
//   CommentModel(
//       username: "Syed Omer",
//       time: "20 Days ago",
//       comment: "Lorem Ipsum is a dumy text",
//       img: "assets/images/profile1.jpg"),
//   CommentModel(
//       username: "Syed Omer",
//       time: "20 Days ago",
//       comment: "Lorem Ipsum is a dumy text",
//       img: "assets/images/profile1.jpg"),
//   CommentModel(
//       username: "Syed Omer",
//       time: "20 Days ago",
//       comment: "Lorem Ipsum is a dumy text",
//       img: "assets/images/profile1.jpg"),
//   CommentModel(
//       username: "Syed Omer",
//       time: "20 Days ago",
//       comment: "Lorem Ipsum is a dumy text",
//       img: "assets/images/profile1.jpg"),
//   CommentModel(
//       username: "Syed Omer",
//       time: "20 Days ago",
//       comment: "Lorem Ipsum is a dumy text",
//       img: "assets/images/profile1.jpg"),
// ];
// final List<TreatModel> dollar = [
//   TreatModel(treats: "100", price: "\$20"),
//   TreatModel(treats: "200", price: "\$20"),
//   TreatModel(treats: "300", price: "\$20"),
//   TreatModel(treats: "400", price: "\$20"),
//   TreatModel(treats: "500", price: "\$20"),
//   TreatModel(treats: "600", price: "\$20"),
//   TreatModel(treats: "100", price: "\$20"),
//   TreatModel(treats: "200", price: "\$20"),
//   TreatModel(treats: "300", price: "\$20"),
//   TreatModel(treats: "400", price: "\$20"),
//   TreatModel(treats: "500", price: "\$20"),
//   TreatModel(treats: "600", price: "\$20"),
// ];

// final List<GridModel1> grid1 = [
//   GridModel1(
//       img: AppAssets.gridimg, title: "First dog", comment: "1", favourite: "5"),
//   GridModel1(
//       img: AppAssets.gridimg, title: "First dog", comment: "1", favourite: "5"),
//   GridModel1(
//       img: AppAssets.gridimg, title: "First dog", comment: "1", favourite: "5"),
//   GridModel1(
//       img: AppAssets.gridimg, title: "First dog", comment: "1", favourite: "5"),
//   GridModel1(
//       img: AppAssets.gridimg, title: "First dog", comment: "1", favourite: "5"),
// ];

// final List<AppModel> app = [
//   AppModel(img: AppAssets.appitem2, title: "Setgipping", price: "\$20"),
//   AppModel(img: AppAssets.appitem1, title: "Setgipping", price: "\$20"),
//   AppModel(img: AppAssets.appitem2, title: "Setgipping", price: "\$20"),
//   AppModel(img: AppAssets.appitem1, title: "Setgipping", price: "\$20"),
//   AppModel(img: AppAssets.appitem1, title: "Setgipping", price: "\$20"),
//   AppModel(img: AppAssets.appitem2, title: "Setgipping", price: "\$20"),
//   AppModel(img: AppAssets.appitem1, title: "Setgipping", price: "\$20"),
//   AppModel(img: AppAssets.appitem1, title: "Setgipping", price: "\$20"),
// ];

class CustomTextField extends StatefulWidget {
  final String hinttext;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool
      showSuffixIcon; 

  CustomTextField({
    required this.hinttext,
    required this.controller,
    required this.validator,
    this.showSuffixIcon = true,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.showSuffixIcon ? _isObscure : false,
      validator: widget.validator,
      textAlign: TextAlign.start,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        filled: true,
        fillColor: AppColors
            .textfieldcolor, // You can replace it with Customitems.textfieldcolor
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        hintText: widget.hinttext,
        focusColor: Colors.transparent,
        hintStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: widget.showSuffixIcon
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.whitecolor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
            // Show suffix icon only if showSuffixIcon is true
      ),

    );
  }
}

class CustomAuth extends StatelessWidget {
  final String assetpath;
  final VoidCallback onTap;

  CustomAuth({required this.assetpath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 23,
        backgroundImage: AssetImage(assetpath),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 55),
      child: Container(
        height: Get.height * 0.117,
        width: Get.width * 0.39,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.signin), fit: BoxFit.fill)),
      ),
    );
  }
}