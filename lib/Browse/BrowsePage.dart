import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:research_mayora/Browse/BrowseController.dart';
import 'package:research_mayora/Browse/CardBrowse.dart';
import 'package:research_mayora/Camera/CameraPreviewPage.dart';
import 'package:get/get.dart';
import 'dart:math' show pi;

class BrowsePage extends StatelessWidget {
  final DataTableSource _data = DummyData();

  @override
  Widget build(BuildContext context) {
    BrowseController controller = Get.put(BrowseController());

    Future.delayed(Duration.zero, () {
      controller.onGetListRecog();
    });

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: SizedBox(
              width: Get.size.width * 0.9,
              child: Row(
                children: [
                  Text(
                    'List of Recognized Exp.',
                    style: TextStyle(
                        color: const Color(0xff495895).withOpacity(.9),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffb9c9f7).withOpacity(.7),
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.refresh, color: Color(0xff515fff)),
                      onPressed: () {
                        controller.onGetListRecog();
                        controller.onClearTextField();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: Get.size.width * 0.9,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.size.width * 0.75,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffb9c9f7).withOpacity(.7),
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
                        controller: controller.fieldFind,
                        onChanged: (String query) {
                          controller.onSearchRecog(query: query);
                        },
                        cursorColor: const Color(0xff515fff),
                        decoration: InputDecoration(
                          fillColor: const Color(0xffFFFFFF),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none),
                          labelText: 'Search',
                          labelStyle: const TextStyle(color: Color(0xff515fff)),
                          suffixIcon: Obx(() => controller
                                  .isTextFieldEmpty.isFalse!
                              ? IconButton(
                                  onPressed: () =>
                                      controller.onClearTextField(),
                                  icon: Icon(
                                    Icons.clear,
                                    color:
                                        const Color(0xff515fff).withOpacity(1),
                                  ))
                              : const Text("")),
                          prefixIcon: Icon(
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
                      width: Get.size.width * 0.12,
                      height: Get.size.height * 0.065,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffb9c9f7).withOpacity(.7),
                            blurRadius: 10.0, // soften the shadow
                            spreadRadius: 0.0, //extend the shadow
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              0.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.calendar_month,
                            color: Color(0xff515fff)),
                        onPressed: () {
                          controller.onLockedNextDatePickerData(
                              context: context, dateformat: 'yyyy-MM-dd');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: SizedBox(
              height: Get.size.height * .6,
              width: Get.size.width * 1,
              child: Obx(() => controller.isLoading.isFalse &&
                      controller.lsFilterRecog.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.lsFilterRecog.length,
                      itemBuilder: (context, index) {
                        return CardBrowse(controller: controller, index: index);
                      })
                  : controller.isLoading.isFalse &&
                          controller.lsFilterRecog.isEmpty
                      ? SizedBox(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/empty_search.json',
                              width: 250,
                              height: 170,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              'The data you are looking for is not available',
                              style: TextStyle(
                                  color: Color(0xff495895).withOpacity(.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ))
                      : SizedBox(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/search.json',
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                            // Text(
                            //   'Please wait...',
                            //   style: TextStyle(
                            //       color: Color(0xff495895).withOpacity(.9),
                            //       fontSize: 20,
                            //       fontWeight: FontWeight.w600),
                            // ),
                          ],
                        ))),
            ),
          ),
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
