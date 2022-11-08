import 'package:flutter/material.dart';
import 'package:research_mayora/homepagecontroller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text('Login first to download the file'),
            TextFormField(
              controller: controller.username,
              decoration: const InputDecoration(
                icon: Icon(Icons.favorite),
                labelText: 'username',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                labelText: 'password',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
            const SizedBox(height: 22),
            ElevatedButton(
                onPressed: (){
                  controller.getToken();
                },
                child: const Text('Get Token')
            ),
            const Text('tap button down below to download the file'),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        controller.downloadFile();
                      },
                      child: const Text('Start Download')
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        controller.openFile();
                      },
                      child: const Text('Open file')
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
