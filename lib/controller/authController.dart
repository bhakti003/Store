import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_store/model/user_model.dart';
import 'package:food_store/screens/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'dashboardController.dart';

class AuthController extends GetxController {
  var pickedImageFilePath = ''.obs;

  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController editNameController = TextEditingController();
  TextEditingController editPhoneController = TextEditingController();
  TextEditingController editDobController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();

  userLogin() async {
    try {
      EasyLoading.show(status: 'loading');
      var res = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLoginController.text,
          password: passwordLoginController.text);

      if (res.user != null) {
        GetStorage().write('uid', res.user!.uid);

        Get.offAll(() => DashBoardPage());
      }
      EasyLoading.dismiss();
    } catch (e) {
      print('Erorr:: :: ${e.toString()}');

      EasyLoading.dismiss();
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: Duration(seconds: 3),
      ));
    }
  }

  userSignup() async {
    try {
      EasyLoading.show(status: 'loading');
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (res.user != null) {
        GetStorage().write('uid', res.user!.uid);

        var userData = Userdata(
          email: emailController.text,
          dob: dobController.text,
          fullName: fullNameController.text,
          phone: phoneController.text,
          favoriteItemData: [],
          profileUrl: '',
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(res.user!.uid)
            .set(userData.toJson());
        Get.offAll(() => DashBoardPage());
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();

      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: Duration(seconds: 3),
      ));
    }
  }

  imagePiker() async {
    await ImagePicker.platform
        .getImage(source: ImageSource.gallery)
        .then((value) {
      pickedImageFilePath.value = value!.path;
    });
  }

  editProfile() async {
    try {
      var uid = GetStorage().read('uid');

      EasyLoading.show(status: 'loading');

      await FirebaseStorage.instance
          .ref("users/$uid.jpg")
          .putFile(File(pickedImageFilePath.value));
      var imageUrl =
          await FirebaseStorage.instance.ref("users/$uid.jpg").getDownloadURL();
      print(imageUrl);

      var updateUserData = Userdata(
          email: editEmailController.text,
          dob: editDobController.text,
          fullName: editNameController.text,
          phone: editPhoneController.text,
          profileUrl: imageUrl,
          favoriteItemData: []);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updateUserData.toJson());
    } catch (e) {
      print('ERROR :: :: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();

      Get.back();
    }
  }

  preFillData() {
    DashBoardController dashBoardController = Get.put(DashBoardController());

    editNameController.text = dashBoardController.userData.value.fullName!;
    editEmailController.text = dashBoardController.userData.value.email!;
    editDobController.text = dashBoardController.userData.value.dob!;
    editPhoneController.text = dashBoardController.userData.value.phone!;
  }
}
