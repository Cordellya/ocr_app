import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';
import 'package:research_mayora/AboutPage.dart';
import 'package:research_mayora/Browse/BrowsePage.dart';
import 'package:research_mayora/Camera/CameraController.dart';

class CameraPreviewPage extends StatelessWidget {
  CameraPreviewPage({Key? key}) : super(key: key);

  final PageCameraController ctrl = Get.put(PageCameraController());

  @override
  Widget build(BuildContext context) {
    print(ctrl.camInitialized.isTrue);

    Future.delayed(
        Duration.zero, () => ctrl.onShowInformation(context: context));

    return Scaffold(
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
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 40.0,
                                width: 40.0,
                                child: FittedBox(
                                  child: FloatingActionButton(
                                    onPressed: () => _modalBottom(context),
                                    backgroundColor:
                                        Colors.black.withOpacity(0.2),
                                    splashColor: Colors.white.withOpacity(0.5),
                                    elevation: 0,
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 35,
                                    ),
                                  ),
                                )))
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
              )));
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
                onTap: () => Get.to(() => BrowsePage()),
              ),
              ListTile(
                leading: const Icon(Icons.priority_high, color: Colors.black),
                title: const Text('About',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    )),
                onTap: () => Get.to(() => AboutPage()),
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
    final paint = Paint()..color = Colors.black54;

    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addRRect(RRect.fromRectAndRadius(
              Rect.fromCenter(
                  center: Offset(size.width * 0.5, size.height * 0.5),
                  width: size.width * 0.5,
                  height: size.height * 0.3),
              const Radius.circular(4),
            ))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
