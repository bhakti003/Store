import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_store/model/item_data_model.dart';
import 'package:food_store/model/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'authController.dart';

class DashBoardController extends GetxController {
  TextEditingController searchController = TextEditingController();
  var userData = Userdata().obs;
  AuthController authController = Get.put(AuthController());
  var favItemList = <ItemData>[].obs;

  var foodList = <ItemData>[].obs;
  var snacksList = <ItemData>[].obs;
  var drinkList = <ItemData>[].obs;
  var sauceList = <ItemData>[].obs;
  var totalItemList = <ItemData>[].obs;

  getUserData() async {
    var uid = GetStorage().read('uid');

    var res =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (res.data() != null) {
      userData.value = Userdata.fromJson(res.data()!);
      print('userdata:: :: ${userData.value.toJson()}');
    }
  }

  getTotalItemList() async {
    await FirebaseFirestore.instance
        .collection('foodItems')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        totalItemList.add(ItemData.fromJson(element.data()));
      });
    });
    foodList.value =
        totalItemList.where((p0) => p0.itemCategory == 'food').toList();
    snacksList.value =
        totalItemList.where((p0) => p0.itemCategory == 'snacks').toList();
    drinkList.value =
        totalItemList.where((p0) => p0.itemCategory == 'drinks').toList();
    sauceList.value =
        totalItemList.where((p0) => p0.itemCategory == 'sauce').toList();
  }

  addToFavorite(String itemId) async {
    var id = GetStorage().read('uid');
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'favList': FieldValue.arrayUnion([itemId])
    });
    getUserData();
  }

  removeFromFavorite(String itemId) async {
    var id = GetStorage().read('uid');
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'favList': FieldValue.arrayRemove([itemId])
    });
    getUserData();
  }

// getItemList() async {
//     await FirebaseFirestore.instance
//         .collection('foodItems')
//         .where('itemCategory', isEqualTo: 'food')
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         print('element ::  ${element.data()}');
//         foodList.add(element.data());
//       });
//     });
//   }
  favoriteItemList() async {
    favItemList.clear();
    await FirebaseFirestore.instance
        .collection('foodItems')
        .where('itemId', whereIn: userData.value.favoriteItemData)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        favItemList.add(ItemData.fromJson(element.data()));
      });
    });
  }
}
