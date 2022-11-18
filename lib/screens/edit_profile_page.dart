import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constant.dart';
import '../controller/authController.dart';
import '../controller/dashboardController.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  void initState() {
    authController.preFillData();

    super.initState();
  }

  AuthController authController = Get.put(AuthController());
  DashBoardController dashBoardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 26.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back)),
              SizedBox(
                height: 16.sp,
              ),
              Text(
                'Edit Profile',
                style: GoogleFonts.quicksand(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.sp,
              ),
              Obx(
                () => Center(
                  child: GestureDetector(
                    onTap: () {
                      authController.imagePiker();
                    },
                    child: Container(
                      height: 90.sp,
                      width: 90.sp,
                      clipBehavior: Clip.antiAlias,
                      child: dashBoardController.userData.value.profileUrl !=
                                  '' &&
                              authController.pickedImageFilePath.value == ''
                          ? CachedNetworkImage(
                              imageUrl: dashBoardController
                                      .userData.value.profileUrl ??
                                  '',
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: 20.h,
                              width: 20.h,
                              fit: BoxFit.cover,
                            )
                          : authController.pickedImageFilePath.value != ''
                              ? Image.file(
                                  File(
                                      authController.pickedImageFilePath.value),
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.person, size: 20.w),
                      decoration: const BoxDecoration(
                        color: ColorConstant.primaryColorWhite,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 26.sp,
              ),
              TextFormField(
                controller: authController.editNameController,
                decoration: InputDecoration(
                    fillColor: ColorConstant.primaryColorLightGrey,
                    filled: true,
                    hintText: 'Full Name',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(26.sp))),
              ),
              SizedBox(
                height: 16.sp,
              ),
              TextFormField(
                controller: authController.editPhoneController,
                decoration: InputDecoration(
                    fillColor: ColorConstant.primaryColorLightGrey,
                    filled: true,
                    hintText: 'Phone',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(26.sp))),
              ),
              SizedBox(
                height: 16.sp,
              ),
              TextFormField(
                controller: authController.editDobController,
                decoration: InputDecoration(
                    fillColor: ColorConstant.primaryColorLightGrey,
                    filled: true,
                    hintText: 'Date of birth',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(26.sp))),
              ),
              SizedBox(
                height: 16.sp,
              ),
              TextFormField(
                controller: authController.editEmailController,
                decoration: InputDecoration(
                    fillColor: ColorConstant.primaryColorLightGrey,
                    filled: true,
                    hintText: 'Email',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(26.sp))),
              ),
              SizedBox(
                height: 22.w,
              ),
              GestureDetector(
                onTap: () {
                  authController.editProfile();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp),
                  child: Container(
                    height: 5.5.h,
                    width: 90.w,
                    color: ColorConstant.primaryColorRed,
                    child: Center(
                      child: Text(
                        'Save',
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
      ),
    );
  }
}
