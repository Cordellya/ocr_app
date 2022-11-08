import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:research_mayora/widget/Glassmorphism.dart';
import 'package:get/get.dart';
import 'dart:math' show pi;

class BrowsePage extends StatelessWidget {
  final DataTableSource _data = DummyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF3F6FA),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff495895),
        ),
        backgroundColor: const Color(0xffF3F6FA),
        elevation: 0,
        title: const Text(
          'Browse',
          style: TextStyle(color: Color(0xff495895)),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            right: -10,
            top: -25,
            child: Lottie.asset(
              'assets/lottie/search.json',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List of Recognized Exp.',
                  style: TextStyle(
                      color: const Color(0xff495895).withOpacity(.9),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  width: Get.size.width * 0.9,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffb9c9f7).withOpacity(.9),
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          0.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: TextField(
                    cursorColor: const Color(0xff515fff),
                    decoration: InputDecoration(
                      fillColor: const Color(0xffFFFFFF),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none),
                      labelText: 'Search',
                      labelStyle: const TextStyle(color: Color(0xff515fff)),
                      suffixIcon: Icon(
                        Icons.search,
                        color: const Color(0xff515fff).withOpacity(1),
                      ),
                      focusColor: const Color(0xff515fff),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xff515fff),
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  // height: Get.size.height * 0.6,
                  width: Get.size.width * 0.9,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffb9c9f7).withOpacity(.8),
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          0.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: PaginatedDataTable(
                          source: _data,
                          columns: const [
                            DataColumn(label: Text('id')),
                            DataColumn(label: Text('item')),
                          ],
                          rowsPerPage: 8,
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DummyData extends DataTableSource {
  final List<Map<String, dynamic>> _data =
      List.generate(50, (index) => {"id": index, "title": "item $index"});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]['title'].toString()))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
