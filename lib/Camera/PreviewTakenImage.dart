import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:research_mayora/Camera/CameraController.dart';

class PreviewTakenImage extends StatelessWidget {
  // final String? file;
  const PreviewTakenImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageCameraController controller = Get.put(PageCameraController());

    return Scaffold(
      backgroundColor: const Color(0xffF3F6FA),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff495895),
        ),
        backgroundColor: const Color(0xffF3F6FA),
        elevation: 0,
        title: const Text(
          'Preview',
          style: TextStyle(color: Color(0xff495895)),
        ),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Obx(
          //   () =>
          Wrap(
            runSpacing: 8.0,
            spacing: 8.0,
            children: [
              // for (int i = 0; i < controller.lsFilePath.length; i++)
              Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                            child: Image.file(
                          File(controller.previewFile.value),
                          height: Get.size.height * 0.75,
                          width: Get.size.width * 1,
                          fit: BoxFit.fill,
                        )),
                      ))),

              SizedBox(
                height: Get.size.height * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ElevatedButton(
                    //   onPressed: () => Get.to(() => CameraPreviewPage()),
                    //   child: const Icon(Icons.done_rounded,
                    //       color: Colors.white, weight: 50),
                    //   style: ButtonStyle(
                    //     shape: MaterialStateProperty.all(CircleBorder()),
                    //     padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    //     backgroundColor: MaterialStateProperty.all(
                    //         Colors.blue), // <-- Button color
                    //     overlayColor:
                    //         MaterialStateProperty.resolveWith<Color?>((states) {
                    //       if (states.contains(MaterialState.pressed))
                    //         return Colors.red; // <-- Splash color
                    //     }),
                    //   ),
                    // )
                    ClipOval(
                      child: Material(
                        // color: Colors.blue, // Button color
                        child: InkWell(
                          splashColor: Colors.red, // Splash color
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 40,
                              )),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(30)),
                    ClipOval(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              // Color(0xff495895),
                              Color(0xff515fff),
                              Color(0xffb9c9f7)
                            ],
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: const Color(0xff495895),
                            onTap: () {
                              controller.onSaveImage(
                                  file: controller.previewFile.value);
                            },
                            child: const SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.done_rounded,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
            // ),
          ),
        ],
      ),
    );
  }
}
