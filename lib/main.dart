import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:research_mayora/Camera/CameraPreviewPage.dart';
import 'package:research_mayora/homepage.dart';
import 'package:research_mayora/permission_handler.dart';

void main() async {
  //ensure flutter widget run
  WidgetsFlutterBinding.ensureInitialized();

  await PermissionHandler().onCheckPlatformSpecific();

  //lock app orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CameraPreviewPage(),
    );
  }
}
