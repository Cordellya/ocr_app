import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:research_mayora/Camera/PredicDataModel.dart';

class BrowseController extends GetxController {
  var isLoading = false.obs;
  var isTextFieldEmpty = true.obs;
  var lsRecog = List<PredictDataModel>.empty(growable: true).obs;
  var lsFilterRecog = List<PredictDataModel>.empty(growable: true).obs;
  final urlList = "https://api.mayora.co.id/get_list_recognition";
  final TextEditingController fieldFind = TextEditingController();

  onGetListRecog() async {
    isLoading.value = true;
    lsRecog.clear();
    //tampilin loading

    //get datanya
    String result = "";
    try {
      dio.Response response = await dio.Dio().post(urlList);
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
    onAssignListRecog(data: result);
  }

  onAssignListRecog({required String data}) {
    var jsonData = jsonDecode(data);
    var resultData = jsonData['result'];

    for (var item in resultData) {
      lsRecog.add(PredictDataModel.fromJson(item));
      lsFilterRecog.add(PredictDataModel.fromJson(item));
    }
    print(lsRecog[0].product_code);
    isLoading.value = false;
  }

  onSearchRecog({required String query}) {
    // print(query);
    isTextFieldEmpty.value = false;
    var tempData = List<PredictDataModel>.empty(growable: true).obs;
    tempData.clear();

    if (query.isNotEmpty) {
      for (var data in lsRecog) {
        if (data.exp_date!.toLowerCase().contains(query.toLowerCase())) {
          tempData.add(data);
        } else if (data.product_code!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          tempData.add(data);
        } else if (data.created_date!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          tempData.add(data);
        }
      }
      lsFilterRecog.clear();
      lsFilterRecog.addAll(tempData);
      lsFilterRecog.refresh();
    } else {
      lsFilterRecog.clear();
      lsFilterRecog.addAll(lsRecog);
      lsFilterRecog.refresh();
    }
  }

  onClearTextField() {
    isTextFieldEmpty.value = true;
    fieldFind.clear();
    lsFilterRecog.clear();
    lsFilterRecog.addAll(lsRecog);
    lsFilterRecog.refresh();
  }

  onLockedNextDatePickerData(
      {required BuildContext context, required String dateformat}) async {
    String formatedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1),
      lastDate: DateTime
          .now(), //hilangin aja ini buat locked tanggal besok karena pasti belum ada data buat tanggal esok
    );
    if (picked != null) {
      formatedDate = DateFormat(dateformat).format(picked);
      fieldFind.text = formatedDate;
      onSearchRecog(query: formatedDate);
    }
  }
}
