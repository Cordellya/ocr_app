import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {

  onCheckPlatformSpecific() async {
    if(Platform.isAndroid){
      onCheckPermissionStatus();
      onRequestPermanentDevicePermission();
    } else if(Platform.isIOS){
      //auto start when device is IOS
    }
  }

  Future<bool> onCheckPermissionStatus() async {
    bool result = false;
    var cameraPermission = await Permission.camera.status;
    var storagePermission = await Permission.storage.status;

    if(cameraPermission.isDenied || storagePermission.isDenied){
      await [Permission.camera, Permission.storage].request();
    } else {
      result = true;
    }
    return result;
  }

  onRequestPermanentDevicePermission() async {
    var cameraPermission = await Permission.camera.status;
    var storagePermission = await Permission.storage.status;

    if(cameraPermission.isPermanentlyDenied ||
        storagePermission.isPermanentlyDenied){
      openAppSettings();
    }
  }
}