import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';
import 'package:research_mayora/About/AboutPage.dart';
import 'package:research_mayora/Browse/BrowsePage.dart';
import 'package:research_mayora/Camera/CameraController.dart';
import 'package:research_mayora/OnAppCloseController.dart';

class CameraPreviewPage extends StatelessWidget {
  CameraPreviewPage({Key? key}) : super(key: key);

  final PageCameraController ctrl = Get.put(PageCameraController());
  final OnAppCloseController ctrlClose = Get.put(OnAppCloseController());

  @override
  Widget build(BuildContext context) {
    // print(ctrl.camInitialized.isTrue);

    // Future.delayed(
    //     Duration.zero,
    //     () => ctrl.camInitialized.isTrue
    //         ? ctrl.onShowInformation(context: context)
    //         : null);

    return WillPopScope(
      onWillPop: () => ctrlClose.onCloseApp(context),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
            ),
          ),
          body: Obx(() => ctrl.camInitialized.isTrue
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          SizedBox(
                              height: Get.size.height * 0.8,
                              width: Get.size.width * 1,
                              child: CameraPreview(ctrl.camcontroller)),
                          CustomPaint(
                            size: Size.fromHeight(Get.size.height * 0.8),
                            painter: RectanglePainter(),
                          ),
                          Positioned(
                            top: Get.size.height * 0.28,
                            left: Get.size.width * 0.262,
                            right: Get.size.width * 0.262,
                            bottom: Get.size.height * 0.28,
                            child: CustomPaint(
                              size: Size.fromHeight(Get.size.height * 0.8),
                              painter: MyCustomPainter(
                                  padding: 1, frameSFactor: 0.1),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  height: 40.0,
                                  width: 40.0,
                                  child: FittedBox(
                                    child: FloatingActionButton(
                                      heroTag: 'modal',
                                      onPressed: () => _modalBottom(context),
                                      backgroundColor:
                                          Colors.black.withOpacity(0.2),
                                      splashColor:
                                          Colors.white.withOpacity(0.5),
                                      elevation: 0,
                                      child: Icon(
                                        Icons.more_vert,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  height: 40.0,
                                  width: 40.0,
                                  child: FittedBox(
                                    child: FloatingActionButton(
                                        heroTag: 'flash',
                                        onPressed: () => ctrl.onFlashChange(),
                                        backgroundColor:
                                            Colors.black.withOpacity(0.2),
                                        splashColor:
                                            Colors.white.withOpacity(0.5),
                                        elevation: 0,
                                        child: Obx(
                                          () => ctrl.isFlashOn.isFalse
                                              ? const Icon(
                                                  Icons.flash_off,
                                                  // size: 35,
                                                )
                                              : const Icon(
                                                  Icons.flash_on,
                                                  // size: 35,
                                                ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: Get.size.width * 1,
                      height: Get.size.height * 0.2,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                ctrl.onTakePicture();
                                // print('ditekan');
                              },
                              child: Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(Get.size.width),
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 6)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  // child: SizedBox(
                  //   height: 80,
                  //   width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lottie/loading_robot2.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff515fff),
                        ),
                      )
                    ],
                  ),
                  // ),
                ))),
    );
  }

  void _modalBottom(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          height: Get.size.height * 0.18,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.search, color: Colors.black),
                title: const Text('Browse',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    )),
                onTap: () {
                  Get.back();
                  Get.to(() => BrowsePage());
                },
              ),
              ListTile(
                leading: const Icon(Icons.priority_high, color: Colors.black),
                title: const Text('About',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    )),
                onTap: () {
                  Get.back();
                  Get.to(() => AboutPage());
                },
              )
            ],
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height * 0.3;
    double sw = size.width * 0.5;
    double cornerSide = sh * 0.05;

    final paint = Paint()..color = Colors.black54;
    final borderPaint = Paint()
      ..color = const Color(0xffb9c9f7)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;

    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addRRect(RRect.fromRectAndRadius(
              Rect.fromCenter(
                  center: Offset(size.width * 0.5, size.height * 0.5),
                  width: size.width * 0.45,
                  height: size.height * 0.25),
              const Radius.circular(4),
            ))
            ..close(),
        ),
        paint);
    canvas.drawPath(
        Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(size.width * 0.5, size.height * 0.5),
                width: size.width * 0.45,
                height: size.height * 0.25),
            const Radius.circular(4),
          )),
        borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyCustomPainter extends CustomPainter {
  final double padding;
  final double frameSFactor;

  MyCustomPainter({
    required this.padding,
    required this.frameSFactor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final frameHWidth = size.width * frameSFactor;

    Paint paint = Paint()
      ..color = Colors.transparent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    /// top left
    canvas.drawLine(
      Offset(0 + padding, padding),
      Offset(
        padding + frameHWidth,
        padding,
      ),
      paint..color = const Color(0xff515fff),
    );

    canvas.drawLine(
      Offset(0 + padding, padding),
      Offset(
        padding,
        padding + frameHWidth,
      ),
      paint..color = const Color(0xff515fff),
    );

    /// top Right
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding - frameHWidth, padding),
      paint..color = const Color(0xff515fff),
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding, padding + frameHWidth),
      paint..color = const Color(0xff515fff),
    );

    /// Bottom Right
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding - frameHWidth, size.height - padding),
      paint..color = const Color(0xff515fff),
    );
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding, size.height - padding - frameHWidth),
      paint..color = const Color(0xff515fff),
    );

    /// Bottom Left
    canvas.drawLine(
      Offset(0 + padding, size.height - padding),
      Offset(0 + padding + frameHWidth, size.height - padding),
      paint..color = const Color(0xff515fff),
    );
    canvas.drawLine(
      Offset(0 + padding, size.height - padding),
      Offset(0 + padding, size.height - padding - frameHWidth),
      paint..color = const Color(0xff515fff),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      true; //based on your use-cases
}
