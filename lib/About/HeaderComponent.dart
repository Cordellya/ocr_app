import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.size.height * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cordellya Agatha,',
            style: TextStyle(
                color: const Color(0xff495895).withOpacity(.9),
                fontSize: 25,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/photo2.jpg'))),
          ),
          SizedBox(
            height: 30,
          ),
          FittedBox(
            child: Row(
              children: [
                Chip(
                  backgroundColor: Color(0xFFE1E4F3),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  label: Text(
                    "Teknik Informatika",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3649AE)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Chip(
                  backgroundColor: Color(0xFFE1E4F3),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  label: Text(
                    "Universitas Tarumanagara",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3649AE)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Pembimbing: ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff495895).withOpacity(.9),
                ),
                textAlign: TextAlign.justify,
              ),
              Chip(
                backgroundColor: Color(0xFFE1E4F3),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                label: Text(
                  "LINA S.T., M.Kom., Ph.D.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3649AE)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
