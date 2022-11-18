import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constant.dart';
import '../controller/authController.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool selectedValue = false;
  AuthController authController = Get.put(AuthController());

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
                'Sign up free account',
                style: GoogleFonts.quicksand(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26.sp,
              ),
              TextFormField(
                controller: authController.fullNameController,
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
                controller: authController.passwordController,
                decoration: InputDecoration(
                    fillColor: ColorConstant.primaryColorLightGrey,
                    filled: true,
                    hintText: 'Password',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(26.sp)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            selectedValue = !selectedValue;
                          });
                        },
                        icon: Icon(selectedValue != null && selectedValue
                            ? Icons.visibility
                            : Icons.visibility_off))),
                obscureText: selectedValue,
              ),
              SizedBox(
                height: 16.sp,
              ),
              TextFormField(
                controller: authController.phoneController,
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
                controller: authController.dobController,
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
                controller: authController.emailController,
                decoration: InputDecoration(
                    fillColor: ColorConstant.primaryColorLightGrey,
                    filled: true,
                    hintText: 'Email',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(26.sp))),
              ),
              SizedBox(
                height: 20.w,
              ),
              GestureDetector(
                onTap: () async {
                  await authController.userSignup();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp),
                  child: Container(
                    height: 5.5.h,
                    width: 90.w,
                    color: ColorConstant.primaryColorRed,
                    child: Center(
                      child: Text(
                        'Sign up',
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
