import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_store/constant.dart';
import 'package:food_store/controller/dashboardController.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/cart_controller.dart';
import '../model/item_data_model.dart';

class FoodDetailsPage extends StatefulWidget {
  ItemData? itemDetails;
  FoodDetailsPage({Key? key, this.itemDetails}) : super(key: key);

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  bool isSelected = false;
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  // bool isFavorite = false;
  CartController cartController = Get.find();

  DashBoardController dashBoardController = Get.put(DashBoardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.primaryColorWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 22.0.sp, left: 14.sp, right: 14.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 5.h,
                          width: 5.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstant.primaryColorTitle,
                          ),
                          padding: EdgeInsets.only(left: 5.sp),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorConstant.primaryColorWhite,
                            size: 14.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            if (dashBoardController
                                .userData.value.favoriteItemData!
                                .contains(widget.itemDetails!.itemId)) {
                              dashBoardController.removeFromFavorite(
                                  widget.itemDetails!.itemId!);
                            } else {
                              dashBoardController
                                  .addToFavorite(widget.itemDetails!.itemId!);
                            }
                          },
                          child: Obx(
                            () => dashBoardController
                                    .userData.value.favoriteItemData!
                                    .contains(widget.itemDetails!.itemId)
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 4.h,
                                  )
                                : Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.red,
                                    size: 4.h,
                                  ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.sp, left: 17.sp),
                  child: Text(
                    widget.itemDetails!.itemName!,
                    style: TextStyle(
                        color: ColorConstant.primaryColorTitle,
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 12.0.sp, left: 12.sp, right: 10.sp),
                  child: Text(
                    "With an oven rack in the middle position, preheat oven to 375 degrees Fahrenhet Pour cup of the olive oil into a large, rimmed baking sheet and tum until the pan is evenly coated",
                    style: TextStyle(
                        fontSize: 9.sp, color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 220.sp, top: 12.sp),
                  child: Text(
                    "\$${widget.itemDetails!.itemPrice}",
                    style: TextStyle(
                        color: ColorConstant.primaryColorRed, fontSize: 33.sp),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.h),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 86.sp),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(35.sp)),
                    child: Container(
                      height: 54.h,
                      width: 100.w,
                      color: ColorConstant.primaryColorLightGrey,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.sp),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            width: 34.5.h,
                            height: 34.h,
                            child: CachedNetworkImage(
                              imageUrl: widget.itemDetails!.itemurl ?? '',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          color: ColorConstant.primaryColorRed),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: 20.h,
                              width: 20.h,
                              fit: BoxFit.cover,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 4.5.sp,
                                      blurRadius: 3.5.sp,
                                      offset: Offset(3, 1),
                                      color:
                                          ColorConstant.primaryColorLightGrey)
                                ]),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.sp, right: 20.sp),
                          child: Container(
                              height: 15.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                  color: ColorConstant.primaryColorWhite,
                                  borderRadius: BorderRadius.circular(18.sp),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1.5.sp,
                                        blurRadius: 2.5.sp,
                                        color:
                                            ColorConstant.primaryColorLightGrey)
                                  ]),
                              child: GetBuilder(
                                init: CartController(),
                                builder: (controller) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          cartController.incrementCounter(
                                              widget.itemDetails!);
                                        },
                                        child: Icon(Icons.add),
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      Text(
                                          (widget.itemDetails!.quantity ?? 0)
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                      GestureDetector(
                                          onTap: () {
                                            cartController.decrementCounter(
                                                widget.itemDetails!);
                                          },
                                          child: Icon(Icons.remove)),
                                    ],
                                  );
                                },
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Row(
                        children: [
                          Icon(
                            Icons.fiber_manual_record,
                            color: ColorConstant.primaryColorRed,
                            size: 10.sp,
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          Text('Tomato'),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Icon(
                            Icons.fiber_manual_record,
                            color: ColorConstant.primaryColorRed,
                            size: 10.sp,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Raw red onion'),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Icon(
                            Icons.fiber_manual_record,
                            color: ColorConstant.primaryColorRed,
                            size: 10.sp,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Fish'),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Icon(
                            Icons.fiber_manual_record,
                            color: ColorConstant.primaryColorRed,
                            size: 10.sp,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Pitted'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0.sp, top: 4.sp),
                      child: Text(
                        "Add Ext'ra Topping",
                        style: TextConstant.primaryText,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                          child: isSelected
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        22.sp,
                                      ),
                                      color: ColorConstant.primaryColorRed,
                                    ),
                                    child: Center(
                                        child: Text('Paper',
                                            style: TextStyle(
                                              color: ColorConstant
                                                  .primaryColorWhite,
                                            ))),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          22.sp,
                                        ),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                ColorConstant.primaryColorRed)),
                                    child: Center(
                                        child: Text('Paper',
                                            style: TextStyle(
                                              color:
                                                  ColorConstant.primaryColorRed,
                                            ))),
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected1 = !isSelected1;
                            });
                          },
                          child: isSelected1
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        22.sp,
                                      ),
                                      color: ColorConstant.primaryColorRed,
                                    ),
                                    child: Center(
                                        child: Text('Salt',
                                            style: TextStyle(
                                              color: ColorConstant
                                                  .primaryColorWhite,
                                            ))),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          22.sp,
                                        ),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                ColorConstant.primaryColorRed)),
                                    child: Center(
                                        child: Text('Salt',
                                            style: TextStyle(
                                              color:
                                                  ColorConstant.primaryColorRed,
                                            ))),
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected2 = !isSelected2;
                            });
                          },
                          child: isSelected2
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        22.sp,
                                      ),
                                      color: ColorConstant.primaryColorRed,
                                    ),
                                    child: Center(
                                        child: Text('Souce',
                                            style: TextStyle(
                                              color: ColorConstant
                                                  .primaryColorWhite,
                                            ))),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          22.sp,
                                        ),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                ColorConstant.primaryColorRed)),
                                    child: Center(
                                        child: Text('Souce',
                                            style: TextStyle(
                                              color:
                                                  ColorConstant.primaryColorRed,
                                            ))),
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected3 = !isSelected3;
                            });
                          },
                          child: isSelected3
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        22.sp,
                                      ),
                                      color: ColorConstant.primaryColorRed,
                                    ),
                                    child: Center(
                                        child: Text('Tomato',
                                            style: TextStyle(
                                              color: ColorConstant
                                                  .primaryColorWhite,
                                            ))),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.0.sp, top: 14.sp),
                                  child: Container(
                                    height: 4.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          22.sp,
                                        ),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                ColorConstant.primaryColorRed)),
                                    child: Center(
                                        child: Text('Tomato',
                                            style: TextStyle(
                                              color:
                                                  ColorConstant.primaryColorRed,
                                            ))),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.sp, top: 20.sp),
                      child: Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16.sp,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(
                            width: 1.sp,
                          ),
                          Text('5.0'),
                          SizedBox(
                            width: 105.sp,
                          ),
                          Icon(
                            Icons.access_time,
                            size: 14.sp,
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          Text('10-15 Min')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18.sp,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        cartController.addToCart(widget.itemDetails!);
                        Get.showSnackbar(GetSnackBar(
                          message: 'Your prodcet has been add to cart',
                          duration: Duration(seconds: 3),
                        ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.sp),
                        child: Container(
                          height: 7.h,
                          width: 70.w,
                          color: ColorConstant.primaryColorRed,
                          child: Center(
                            child: Text(
                              'ADD TO CART',
                              style: TextStyle(
                                  color: ColorConstant.primaryColorWhite,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
