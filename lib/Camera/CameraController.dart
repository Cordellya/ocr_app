import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:camera/camera.dart';
import 'package:research_mayora/Camera/PreviewTakenImage.dart';
import 'package:research_mayora/Camera/ResultPage.dart';
import 'package:research_mayora/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:research_mayora/Camera/PredicDataModel.dart';

class PageCameraController extends GetxController with WidgetsBindingObserver {
  var lsCamera = List<CameraDescription>.empty(growable: true).obs;
  late CameraController camcontroller;
  late CameraDescription camera;
  late CameraDescription modulecam;
  late CameraImage imgresult;
  var camInitialized = false.obs;

  var localPath = ''.obs;
  var isShowInfo = true.obs;
  var isFlashOn = false.obs;
  var isSaveImg = false.obs;
  var lsFile = List<XFile>.empty(growable: true).obs;
  var lsFilePath = List<String>.empty(growable: true).obs;
  var previewFile = ''.obs;
  var isLoading = false.obs;
  var resultPredict = PredictDataModel().obs;

  final urlPredict = "https://api.mayora.co.id/predict";

  @override
  void onInit() async {
    // await prepareSaveDir();
    await getDeviceCam();
    await initializeCamera();
    super.onInit();
  }

  @override
  void onReady() {
    onShowInformation();
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // camcontroller.dispose();
      await getDeviceCam();
      await initializeCamera();
    }
  }

  initializeCamera() async {
    // Create the CameraController
    if (await PermissionHandler().onCheckPermissionStatus()) {
      // Create the CameraController
      camcontroller = CameraController(modulecam, ResolutionPreset.medium);
      // Initialize the CameraController
      camcontroller.initialize().then((_) async {
        camcontroller.setFlashMode(FlashMode.off);
        // Start ImageStream
        print('bisa kok');
        camInitialized.value = true;
      });
    } else {}
  }

  onFlashChange() {
    if (isFlashOn.isTrue) {
      camcontroller.setFlashMode(FlashMode.off);
      isFlashOn.value = false;
      log('masuk off');
    } else {
      camcontroller.setFlashMode(FlashMode.always);
      isFlashOn.value = true;
      log('masuk on');
    }
  }

  getDeviceCam() async {
    // Obtain a list of the available cameras on the device.
    lsCamera.value = await availableCameras();
    modulecam = lsCamera[0];
  }

  onTakePicture() async {
    if (camcontroller.value.isInitialized) {
      XFile? file = await onStartTakePicture();

      previewFile.value = file!.path;
      lsFilePath.add(file!.path);
      lsFile.add(file);

      if (previewFile.value != '') {
        Get.back();
        Get.to(() => PreviewTakenImage());
      }

      //ensure camera dispose before back to preview screen
      // await Future.delayed(const Duration(milliseconds: 500), () {
      //   Get.back();
      //   print(file.path);

      //   // GallerySaver.saveImage(file.path, toDcim: true)
      //   //     .then((value) => log('hayoo $value'));

      //   GallerySaver.saveImage(file.path)
      //       .then((value) => log('image saved $value'));
      //   // onStartCropImage(file: lsFile[0]);
      // });
    } else {
      log('error, camera not started');
    }
  }

  onSaveImage({required String file}) async {
    // if (isSaveImg.isTrue) {
    await Future.delayed(const Duration(milliseconds: 500), () async {
      // Get.back();
      // print(file);

      popUpLoading();

      String result = await onUploadImage(file: File(file));
      // isLoading.value = false;
      var json = jsonDecode(result);
      print(json['product_code']);
      resultPredict.value = PredictDataModel.fromJson(json);
      print(resultPredict.value.product_code);

      Get.back();
      Get.to(() => ResultPage(
            code: resultPredict.value.product_code!,
            expdate: resultPredict.value.exp_date!,
            status: resultPredict.value.status!,
          ));
      // Get.back();
      // GallerySaver.saveImage(file.path, toDcim: true)
      //     .then((value) => log('hayoo $value'));

      GallerySaver.saveImage(file).then((value) => log('image saved $value'));
      // onStartCropImage(file: lsFile[0]);
    });
    // }
  }

  onUploadImage({required File file}) async {
    String fileName = file.path.split('/').last;

    var multipart = new http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync());

    String result = 'Error';

    dio.FormData formData = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(file.path, filename: fileName),
    });
    try {
      dio.Response response = await dio.Dio().post(urlPredict, data: formData);
      String resMessage = response.toString();
      if (response.statusCode == 200) {
        result = response.toString();
      } else {
        result = "Error, " + response.statusCode.toString() + resMessage;
      }
    } catch (e) {
      result = 'Error, on connection or server is offline';
    }
    print(result);
    return result;
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

  onStartCropImage({required XFile file}) async {
    CroppedFile? crop = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 3.0, ratioY: 3.0),
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(hideBottomControls: true, lockAspectRatio: true),
        ]);
    lsFilePath.add(crop!.path);
    await GallerySaver.saveImage(crop.path).then((value) => log('image saved'));
  }

  popUpLoading() {
    Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // title: const Center(child: Text('Photo Guide')),
          // titleTextStyle: TextStyle(
          //   color: const Color(0xff495895).withOpacity(.9),
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          // ),
          backgroundColor: const Color(0xffF3F6FA),
          content: SizedBox(
            height: Get.size.height * 0.35,
            width: Get.size.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset(
                  'assets/lottie/scanning.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Text(
                  'Please wait... we are processing your image',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff495895).withOpacity(.9),
                  ),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false);
  }

  // onShowInformation() {
  //   // Get.defaultDialog(
  //   //   title: 'Peringatan',
  //   //   middleText: 'Arahin fotonya yang bener!',
  //   //   textCancel: 'YAA MAAP',
  //   // ).then((value) => isShowInfo.value = false);
  //   Get.dialog(
  //           Stack(
  //             children: [
  //               AlertDialog(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(15.0),
  //                 ),
  //                 title: const Center(child: Text('Photo Guide')),
  //                 titleTextStyle: TextStyle(
  //                   color: const Color(0xff495895).withOpacity(.9),
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 content: SizedBox(
  //                   height: Get.size.height * 0.6,
  //                   width: Get.size.width * 0.8,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       SizedBox(
  //                         height: Get.size.height * 0.4,
  //                         width: Get.size.width * 0.4,
  //                         child: Lottie.asset(
  //                           'assets/lottie/photo_guide.json',
  //                           width: Get.size.height * 1,
  //                           height: Get.size.width * 1,
  //                           fit: BoxFit.fill,
  //                         ),
  //                       ),
  //                       Padding(padding: EdgeInsets.all(10)),
  //                       Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Text(
  //                             'Adjust the white box on the packaging which you want to take the photo with the guide box provided',
  //                             style: TextStyle(
  //                               color: const Color(0xff495895).withOpacity(.9),
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                             textAlign: TextAlign.center,
  //                           ),
  //                           Text(
  //                             '*Important: Please make sure, only includes the white box and its content inside the guide box !!!',
  //                             style: TextStyle(
  //                               color: Colors.red,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                             // textAlign: TextAlign.center,
  //                           )
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   // )
  //                 ),
  //               ),
  //               Positioned(
  //                 bottom: -10,
  //                 right: -40,
  //                 child: Lottie.asset(
  //                   'assets/lottie/robot_guide2.json',
  //                   width: Get.size.width * 0.45,
  //                   height: Get.size.height * 0.23,
  //                   fit: BoxFit.fill,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           barrierDismissible: true)
  //       .then((value) => isShowInfo.value = false);
  // }
  onShowInformation() {
    // Get.defaultDialog(
    //   title: 'Peringatan',
    //   middleText: 'Arahin fotonya yang bener!',
    //   textCancel: 'YAA MAAP',
    // ).then((value) => isShowInfo.value = false);
    Get.dialog(
            Stack(
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
                    height: Get.size.height * 0.55,
                    width: Get.size.width * 0.85,
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: -70,
                          child: SizedBox(
                            height: Get.size.height * 0.4,
                            width: Get.size.width * 0.45,
                            child: Lottie.asset(
                              'assets/lottie/photo_guide.json',
                              width: Get.size.height * 1,
                              height: Get.size.width * 1,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        //  Lottie.asset(
                        //     'assets/lottie/photo_guide.json',
                        //     width: 200,
                        //     height: 400,
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        // Positioned(
                        //   bottom: 50,
                        // child:
                        // Positioned(
                        //   bottom: 0,
                        // child:
                        // SizedBox(
                        //   height: Get.size.height * 0.2,
                        //   width: Get.size.width * 0.7,
                        // child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Adjust the white box on the packaging which you want to take the photo with the guide box provided',
                              style: TextStyle(
                                color: const Color(0xff495895).withOpacity(.9),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(padding: EdgeInsets.all(20)),
                            Text(
                              '*Important: Please make sure, only includes the white box and its content inside the guide box !!!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                          ],
                        ),
                        // ),
                        // )

                        // )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: -40,
                  child: Lottie.asset(
                    'assets/lottie/robot_guide2.json',
                    width: Get.size.width * 0.45,
                    height: Get.size.height * 0.23,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            barrierDismissible: true)
        .then((value) => isShowInfo.value = false);
  }
}
