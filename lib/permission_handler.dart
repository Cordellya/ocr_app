import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> onCheckPlatformSpecific() async {
    bool result = false;
    if (Platform.isAndroid) {
      result = await onCheckPermissionStatus();
    } else if (Platform.isIOS) {
      //auto start when device is IOS
    }
    return result;
  }

  Future<bool> onCheckPermissionStatus() async {
    bool result = false;
    var cameraPermission = await Permission.camera.status;
    var micPermission = await Permission.microphone.status;
    var storagePermission = await Permission.storage.status;

    if (cameraPermission.isDenied ||
        storagePermission.isDenied ||
        micPermission.isDenied) {
      result = false;
    } else {
      result = true;
    }
    return result;
  }

  onRequestPermanentDevicePermission() async {
    var cameraPermission = await Permission.camera.status;
    var micPermission = await Permission.microphone.status;
    var storagePermission = await Permission.storage.status;

    if (cameraPermission.isPermanentlyDenied ||
        storagePermission.isPermanentlyDenied ||
        micPermission.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
