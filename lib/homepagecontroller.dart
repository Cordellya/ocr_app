import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as httpdio;
import 'package:open_file/open_file.dart';

class HomePageController extends GetxController{
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var dirpath = ''.obs;
  late httpdio.Response response;
  var dio = httpdio.Dio();


  @override
  void onInit() async {
    await prepareDir();
    super.onInit();
  }

  getToken() async {
    var url = Uri.parse('https://api.mayora.co.id/v1/logincharlie');
    var response = await http.post(url, body: {'email': username.value, 'password': password.value});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  downloadFile() async {
    String url = 'https://mydrive.mayora.co.id:5001/sharing/u1SE8oZGt';
    response = await dio.download(url, dirpath);
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.data}');
  }

  openFile() async {
    OpenFile.open(dirpath + "");
  }

  prepareDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory dir = Directory(appDocDir.path + '/Attachment');
    dirpath.value = dir.path;
    if(!await dir.exists()){
      print('creating directory');
      dir.create();
    } else {
      print('directory already exist');
    }
  }
}