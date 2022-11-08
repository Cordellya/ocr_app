import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.size.width * 0.9,
                  height: Get.size.height * 0.3,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: const Text('tes doang'),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  width: Get.size.width * 0.9,
                  height: Get.size.height * 0.3,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: const Color(0xff495895).withOpacity(.9),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: const Text('tes doang'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
