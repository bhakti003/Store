import 'package:flutter/material.dart';
import 'package:food_store/constant.dart';
import 'package:food_store/screens/sign_up.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controller/authController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool selectedValue = false;
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 50.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/siginbg.jpg'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.srcOver))),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 24.sp, left: 12.sp),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back,
                          color: Colors.white, size: 20.sp),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.sp),
                    topRight: Radius.circular(18.sp)),
                child: Container(
                  color: ColorConstant.primaryColorWhite,
                  height: 60.h,
                  width: 100.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 24.sp, horizontal: 20.sp),
                    child: SingleChildScrollView(
                      // shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login to your account',
                            style: GoogleFonts.quicksand(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 28.sp,
                          ),
                          TextFormField(
                            controller: authController.emailLoginController,
                            decoration: InputDecoration(
                                fillColor: ColorConstant.primaryColorLightGrey,
                                filled: true,
                                hintText: 'Email',
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(26.sp))),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          TextFormField(
                            controller: authController.passwordLoginController,
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
                                    icon: Icon(
                                        selectedValue != null && selectedValue
                                            ? Icons.visibility
                                            : Icons.visibility_off))),
                            obscureText: selectedValue,
                          ),
                          SizedBox(
                            height: 28.sp,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await authController.userLogin();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.sp),
                              child: Container(
                                height: 5.5.h,
                                width: 86.w,
                                color: ColorConstant.primaryColorRed,
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        color: ColorConstant.primaryColorWhite),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.sp, vertical: 40.sp),
                            child: Center(
                              child: Row(
                                children: [
                                  Text("Don't have an account?"),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(SignUp());
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: ColorConstant.primaryColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          MediaQuery.of(context).viewInsets.bottom != 0
                              ? SizedBox(height: 30.h)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
