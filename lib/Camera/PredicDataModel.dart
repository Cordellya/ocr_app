import 'package:intl/intl.dart';

class PredictDataModel {
  String? exp_date;
  String? product_code;
  String? status;
  String? created_date;

  PredictDataModel(
      {this.exp_date, this.product_code, this.status, this.created_date});

  PredictDataModel.fromJson(Map<String, dynamic> jsonData) {
    exp_date = jsonData['exp_date'];
    product_code = jsonData['product_code'];
    status = jsonData['status'];
    created_date = jsonData['created_date'];
  }
}
