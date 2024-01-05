import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/view/library.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.textback), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Customhead(),
                SizedBox(height: Get.height * 0.06),
                Text(
                  "Ensuring Your Pet's \nWell-being During Play",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(height: Get.height * 0.025),
                Padding(
                  padding: EdgeInsets.only(left: 17, right: 17),
                  child: Text(
                    "At Hide n Squeaks, we prioritize the safety and happiness of your pets. While our app offers engaging interactions and sound experiences, it's crucial to remember a few key safety guidelines. Always supervise your pet during play, especially when they are interacting with the stuffed toy. Ensure that the toy is appropriate for your pet's size and breed to prevent any potential harm. Regularly inspect the toy for any signs of wear or damage, and replace it if necessary to avoid choking hazards or other injuries. Lastly, be mindful of the volume and type of sounds you choose, as pets can be sensitive to certain frequencies. By following these simple steps, you can ensure a fun and safe environment for your beloved companion.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: 1.45),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
