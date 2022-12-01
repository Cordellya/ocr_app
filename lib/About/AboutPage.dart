import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:research_mayora/About/HeaderComponent.dart';
import 'package:research_mayora/Camera/CameraPreviewPage.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffF3F6FA),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xff495895),
          ),
          backgroundColor: const Color(0xffF3F6FA),
          elevation: 0,
          title: const Text(
            'About',
            style: TextStyle(color: Color(0xff495895)),
          ),
          centerTitle: true,
        ),
        body: Align(
          child: SizedBox(
            width: Get.size.width * .85,
            height: Get.size.height * 1,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderComponent(),
                Expanded(
                  child: RawScrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "This application is an application that can recognize the expiration date contained on the product packaging belonging to PT. Torabika Eka Semesta. There are also some limitations in recognizing, namely:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff495895).withOpacity(.9),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "1. The expiry date to be recognized must be on the white box included in the package",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff515fff).withOpacity(.9),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "\n2. Adjust the white box on the packaging with the guide box provided. Please make sure, only includes the white box and its content inside the guide box.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff515fff).withOpacity(.9),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "\n3. Taking photos must be portrait and the text is straight.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff515fff).withOpacity(.9),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "\n4. Please make sure the light is not too bright and not too dark.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff515fff).withOpacity(.9),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Pembimbing: ",
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.w600,
                          //         color: const Color(0xff495895).withOpacity(.9),
                          //       ),
                          //       textAlign: TextAlign.justify,
                          //     ),
                          //     Chip(
                          //       backgroundColor: Color(0xFFE1E4F3),
                          //       padding: const EdgeInsets.symmetric(
                          //           vertical: 10, horizontal: 5),
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(15)),
                          //       label: Text(
                          //         "LINA S.T., M.Kom., Ph.D.",
                          //         style: TextStyle(
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w600,
                          //             color: Color(0xFF3649AE)),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
