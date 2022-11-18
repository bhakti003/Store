import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_store/constant.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../controller/dashboardController.dart';
import '../model/item_data_model.dart';

class FavoriteFoodPage extends StatefulWidget {
  ItemData? itemDetails;

  FavoriteFoodPage({Key? key}) : super(key: key);

  @override
  State<FavoriteFoodPage> createState() => _FavoriteFoodPageState();
}

class _FavoriteFoodPageState extends State<FavoriteFoodPage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());

  bool isFavorite = false;

  @override
  void initState() {
    dashBoardController.favoriteItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.sp, top: 36.sp),
            child: Text(
              'Favorite',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: dashBoardController.favItemList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10.0.sp, right: 10.sp, top: 10.sp),
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Row(
                            children: [
                              Container(
                                height: 14.h,
                                width: 14.h,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorConstant.primaryColorGrey,
                                          spreadRadius: 0.1,
                                          blurRadius: 3.5)
                                    ]),
                                child: CachedNetworkImage(
                                  imageUrl: dashBoardController
                                          .favItemList[index].itemurl ??
                                      '',
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "\$${dashBoardController.favItemList[index].itemPrice}  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                                color: ColorConstant
                                                    .primaryColorRed),
                                          ),
                                          SizedBox(
                                            width: 34.w,
                                          ),
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 18.sp,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        dashBoardController
                                                .favItemList[index].itemName ??
                                            '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
