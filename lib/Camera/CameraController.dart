import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:research_mayora/permission_handler.dart';

class PageCameraController extends GetxController {
  var lsCamera = List<CameraDescription>.empty(growable: true).obs;
  late CameraController camcontroller;
  late CameraDescription camera;
  late CameraDescription modulecam;
  late CameraImage imgresult;
  var camInitialized = false.obs;

  var localPath = ''.obs;
  var isShowInfo = true.obs;
  var lsFile = List<XFile>.empty(growable: true).obs;
  var lsFilePath = List<String>.empty(growable: true).obs;

  @override
  void onInit() async {
    // await prepareSaveDir();
    await getDeviceCam();
    initializeCamera();
    super.onInit();
  }

  initializeCamera() async {
    // Create the CameraController
    if (await PermissionHandler().onCheckPermissionStatus()) {
      // Create the CameraController
      camcontroller = CameraController(modulecam, ResolutionPreset.medium);
      // Initialize the CameraController
      camcontroller.initialize().then((_) async {
        // Start ImageStream
        camInitialized.value = true;
      });
    }
  }

  onShowInformation({required BuildContext context}) {
    // Get.defaultDialog(
    //   title: 'Peringatan',
    //   middleText: 'Arahin fotonya yang bener!',
    //   textCancel: 'YAA MAAP',
    // ).then((value) => isShowInfo.value = false);

    showDialog(
            context: context,
            builder: (context) => Stack(
                  children: [
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      title: const Center(child: Text('Photo Guide')),
                      titleTextStyle: TextStyle(
                        color: const Color(0xff495895).withOpacity(.9),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      content: SizedBox(
                        height: Get.size.height * 0.5,
                        width: Get.size.width * 0.8,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: -90,
                              child: Lottie.asset(
                                'assets/lottie/photo_guide.json',
                                width: 200,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Positioned(
                            //   bottom: 50,
                            // child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Adjust the white box on the packaging that you want to take in the photo with the instructions box provided',
                                  style: TextStyle(
                                    color:
                                        const Color(0xff495895).withOpacity(.9),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: -40,
                      child: Lottie.asset(
                        'assets/lottie/robot_guide2.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
            barrierDismissible: true)
        .then((value) => isShowInfo.value = false);
  }

  getDeviceCam() async {
    // Obtain a list of the available cameras on the device.
    lsCamera.value = await availableCameras();
    modulecam = lsCamera[0];
  }

  // getPicture() async {
  //   await prepareSaveDir();
  //   Directory getPath = await getApplicationDocumentsDirectory();
  //   String localPath = getPath.path + "/File";

  //   XFile img = await camcontroller.takePicture();
  //   File file = File(img.path);
  //   file.copySync(localPath + "/" + "img_mayora_1");
  // }

  onTakePicture() async {
    if (camcontroller.value.isInitialized) {
      XFile? file = await onStartTakePicture();

      Directory getPath = await getApplicationDocumentsDirectory();
      String localPath = getPath.path + "/File";

      File fileDev = File(file!.path);
      fileDev.copySync(localPath + "/" + "img_mayora_1");
      lsFilePath.add(file!.path);
      lsFile.add(file);

      //ensure camera dispose before back to preview screen
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    } else {
      log('error, camera not started');
    }
  }

  onStartTakePicture() async {
    if (camcontroller.value.isTakingPicture) {
      return null;
    }
    try {
      final XFile file = await camcontroller.takePicture();
      return file;
    } on CameraException catch (e) {
      log(e.code + e.description.toString());
      return null;
    }
  }

  prepareSaveDir() async {
    Directory getPath = await getApplicationDocumentsDirectory();
    String localPath = getPath.path + "/File";
    try {
      final savedDir = Directory(localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create(recursive: true);
      }
    } catch (error) {
      print(error);
    }
  }
}
