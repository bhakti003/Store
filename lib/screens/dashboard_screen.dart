import 'package:flutter/material.dart';
import 'package:food_store/constant.dart';
import 'package:food_store/screens/favorite_food_page.dart';
import 'package:food_store/screens/food_list_page.dart';
import 'package:food_store/screens/my_cart_page.dart';
import 'package:food_store/screens/profile_page.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../controller/dashboardController.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key});

  @override
  State<DashBoardPage> createState() => _DashBoardPage();
}

class _DashBoardPage extends State<DashBoardPage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  CartController cartController = Get.put(CartController());

  var selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    dashBoardController.getUserData();
    dashBoardController.getTotalItemList();
    // dashBoardController.getItemList();
    super.initState();
  }

  List<Widget> PageList = [
    FoodListPage(),
    FavoriteFoodPage(),
    MyCartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedIconTheme:
            IconThemeData(shadows: [Shadow(color: Colors.red, blurRadius: 16)]),
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        selectedItemColor: ColorConstant.primaryColorRed,
        unselectedItemColor: ColorConstant.primaryColorGrey,
      ),
      body: PageList.elementAt(selectedIndex),
    );
  }
}
