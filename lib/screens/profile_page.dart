import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_store/constant.dart';
import 'package:food_store/screens/edit_profile_page.dart';
import 'package:food_store/screens/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controller/dashboardController.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryColorWhite,
      body: Obx(
        () => Column(
          children: [
            Stack(
              children: [
                Container(
                  color: ColorConstant.primaryColorRed,
                  height: 20.h,
                  width: 100.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 120.0.sp, top: 70.sp),
                    child: Text(
                        dashBoardController.userData.value.fullName ?? '',
                        style: TextStyle(
                            color: ColorConstant.primaryColorWhite,
                            fontSize: 22.sp)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0.sp, right: 8.sp),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Are you sure you want to sign out?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Sign Out",
                                    style: TextStyle(
                                        color: ColorConstant.primaryColorRed)),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      (route) => false);
                                  GetStorage().remove('uid');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.logout,
                          color: ColorConstant.primaryColorWhite, size: 22.sp),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.sp, left: 16.sp),
                  child: Container(
                    height: 90.sp,
                    width: 90.sp,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: dashBoardController.userData.value.profileUrl != ''
                        ? CachedNetworkImage(
                            imageUrl:
                                dashBoardController.userData.value.profileUrl ??
                                    '',
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            height: 20.h,
                            width: 20.h,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.person, size: 20.w),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 40.h,
                width: 82.w,
                color: ColorConstant.primaryColorLightGrey,
                child: Padding(
                  padding: EdgeInsets.all(14.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(dashBoardController.userData.value.email!),
                      Divider(
                          color: ColorConstant.primaryColorLightGrey,
                          thickness: 2),
                      Text('Phone'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(dashBoardController.userData.value.phone!),
                      Divider(
                          color: ColorConstant.primaryColorLightGrey,
                          thickness: 2),
                      Text('Date of brith'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(dashBoardController.userData.value.dob!),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 14.w,
            ),
            GestureDetector(
              onTap: () async {
                // Get.to(() => EditProfilePage())!.then((value) {
                //   dashBoardController.userData.value;
                //   dashBoardController.getUserData();
                //   print(
                //       "UserData1 :: :: :: ${dashBoardController.userData.value.fullName}");
                // });
                await Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => EditProfilePage()))
                    .then((value) {
                  dashBoardController.userData.value;
                  dashBoardController.getUserData();
                  print(
                      "UserData1 :: :: :: ${dashBoardController.userData.value.fullName}");
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.sp),
                child: Container(
                  height: 5.5.h,
                  width: 90.w,
                  color: ColorConstant.primaryColorRed,
                  child: Center(
                    child: Text(
                      'Edit',
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: ColorConstant.primaryColorWhite),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
