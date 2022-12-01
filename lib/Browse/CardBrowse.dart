import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:research_mayora/Browse/BrowseController.dart';

class CardBrowse extends StatelessWidget {
  const CardBrowse({Key? key, required this.controller, required this.index})
      : super(key: key);

  final BrowseController controller;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      child: Container(
        width: Get.size.width * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffb9c9f7).withOpacity(.7),
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.lsFilterRecog[index].created_date!,
                      style: TextStyle(
                          color: Color(0xff495895).withOpacity(.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      controller.lsFilterRecog[index].status!,
                      style: TextStyle(
                        color: controller.lsRecog[index].status == 'Valid'
                            ? Colors.green
                            : controller.lsRecog[index].status == 'Not Valid'
                                ? Colors.red
                                : Colors.orange[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Exp. date",
                          style: TextStyle(
                              color: Color(0xff495895).withOpacity(.9),
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Chip(
                          padding: EdgeInsets.all(10),
                          backgroundColor: Color(0xffE6E7FC),
                          label: Text(
                            controller.lsFilterRecog[index].exp_date != ""
                                ? controller.lsFilterRecog[index].exp_date!
                                : "---",
                            style: TextStyle(
                                color: Color(0xff515fff).withOpacity(1),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Product code",
                          style: TextStyle(
                              color: Color(0xff495895).withOpacity(.9),
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Chip(
                          padding: EdgeInsets.all(10),
                          backgroundColor: Color(0xffE6E7FC),
                          label: Text(
                            controller.lsFilterRecog[index].product_code != ""
                                ? controller.lsFilterRecog[index].product_code!
                                : "---",
                            style: TextStyle(
                              color: Color(0xff515fff).withOpacity(1),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
