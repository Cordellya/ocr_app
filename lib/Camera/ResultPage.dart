import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:research_mayora/Camera/CameraPreviewPage.dart';

class ResultPage extends StatelessWidget {
  final String expdate;
  final String code;
  final String status;

  ResultPage({required this.expdate, required this.code, required this.status});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.off(CameraPreviewPage());
        Get.close(2);
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffF3F6FA),
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Color(0xff495895),
            ),
            backgroundColor: const Color(0xffF3F6FA),
            elevation: 0,
            title: const Text(
              'Result Prediction',
              style: TextStyle(color: Color(0xff495895)),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView
          (
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/success.json',
                    width: 250,
                    height: 230,
                    fit: BoxFit.fill,
                  ),

                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    width: Get.size.width * 0.7,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffb9c9f7).withOpacity(.8),
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 30, 8, 30),
                        child: Column(
                          children: [
                            Text(
                              'Exp. Date',
                              style: TextStyle(
                                color: const Color(0xff495895).withOpacity(.9),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              expdate,
                              style: TextStyle(
                                color: const Color(0xff515fff),
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              thickness: 2,
                              color: const Color(0xff515fff).withOpacity(.5),
                              endIndent: Get.size.width * .25,
                              indent: Get.size.width * .25,
                              height: 50,
                            ),
                            Text(
                              'Product Code',
                              style: TextStyle(
                                color: const Color(0xff495895).withOpacity(.9),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              code,
                              style: TextStyle(
                                color: const Color(0xff515fff),
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //PRODUCT CODE
                  // Text(
                  //   'Product Code',
                  //   style: TextStyle(
                  //     color: const Color(0xff495895).withOpacity(.9),
                  //     fontSize: 23,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: Get.size.width * 0.7,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: const Color(0xffb9c9f7).withOpacity(.8),
                  //         blurRadius: 10.0, // soften the shadow
                  //         spreadRadius: 0.0, //extend the shadow
                  //         offset: Offset(
                  //           0.0, // Move to right 10  horizontally
                  //           0.0, // Move to bottom 10 Vertically
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(
                  //         code,
                  //         style: TextStyle(
                  //           color: const Color(0xff515fff),
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    'Status :',
                    style: TextStyle(
                      color: const Color(0xff495895).withOpacity(.9),
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: Get.size.width * 0.7,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffb9c9f7).withOpacity(.8),
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Column(
                          children: [
                            Text(
                              status,
                              style: TextStyle(
                                color: status == 'Valid'
                                    ? Colors.green
                                    : status == 'Not Valid'
                                        ? Colors.red
                                        : Colors.orange[800],
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            status == 'Unknown'
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      "Oops... We can't specify the status due to inaccurate year of exp.date prediction",
                                      style: TextStyle(
                                        color: const Color(0xff495895)
                                            .withOpacity(.9),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
