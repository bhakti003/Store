import 'package:flutter/material.dart';
import 'package:food_store/constant.dart';
import 'package:food_store/screens/dashboard_screen.dart';
import 'package:food_store/screens/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FristPage extends StatefulWidget {
  const FristPage({Key? key}) : super(key: key);

  @override
  State<FristPage> createState() => _FristPageState();
}

class _FristPageState extends State<FristPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('images/foodbg.jpg',
              width: 100.w, height: 100.h, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              children: [
                Center(
                    child: Text('Food GO!',
                        style: GoogleFonts.caveat(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        ))),
                Text(
                  'Get your favorite food from here',
                  style: GoogleFonts.exo2(
                      fontWeight: FontWeight.w600, wordSpacing: 4),
                )
              ],
            ),
          ),
          Positioned(
            left: 39.w,
            top: 79.h,
            child: Container(
              width: 22.5.w,
              height: 22.5.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: ColorConstant.primaryColorRed, width: 2)),
            ),
          ),
          Positioned(
            left: 41.w,
            top: 80.h,
            child: GestureDetector(
              onTap: () {
                var uid = GetStorage().read('uid') ?? '';
                uid != ''
                    ? Get.to(() => DashBoardPage())
                    : Get.to(() => LoginPage());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: ColorConstant.primaryColorRed,
                  width: 18.5.w,
                  height: 18.5.w,
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      color: ColorConstant.primaryColorWhite, size: 26.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
