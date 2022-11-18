import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_store/constant.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controller/cart_controller.dart';
import '../model/item_data_model.dart';

class MyCartPage extends StatefulWidget {
  ItemData? itemDetails;
  MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryColorWhite,
      body: GetBuilder(
        init: CartController(),
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: Text(
                'My Cart',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: cartController.cartItemList.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 10.sp, right: 10.sp, left: 10.sp),
                      child: ClipRRect(
                        child: Container(
                          height: 14.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: ColorConstant.primaryColorWhite,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.primaryColorLightGrey,
                                )
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 14.h,
                                width: 14.h,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: cartController
                                          .cartItemList[index].itemurl ??
                                      '',
                                  // child: Image.network(
                                  //   (cartController.cartItemList[index]
                                  //           as ItemData)
                                  //       .itemurl!,
                                  fit: BoxFit.cover,
                                  // height: 100.sp,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$${(cartController.cartItemList[index] as ItemData).itemPrice}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: ColorConstant.primaryColorRed),
                                    ),
                                    Text(
                                      (cartController.cartItemList[index]
                                              as ItemData)
                                          .itemName!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 12.sp,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 2.sp, right: 20.sp),
                                            child: Container(
                                              width: 15.h,
                                              height: 10.w,
                                              decoration: BoxDecoration(
                                                  color: ColorConstant
                                                      .primaryColorWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.sp),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 1.5.sp,
                                                        blurRadius: 2.5.sp,
                                                        color: ColorConstant
                                                            .primaryColorLightGrey)
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController
                                                          .incrementCounter(
                                                              cartController
                                                                      .cartItemList[
                                                                  index]);
                                                      print((cartController
                                                                  .cartItemList[
                                                              index] as ItemData)
                                                          .quantity);
                                                    },
                                                    child: Icon(Icons.add),
                                                  ),
                                                  SizedBox(
                                                    height: 5.sp,
                                                  ),
                                                  Text(
                                                    ((cartController.cartItemList[
                                                                        index]
                                                                    as ItemData)
                                                                .quantity ??
                                                            0)
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        cartController
                                                            .decrementCounter(
                                                                cartController
                                                                        .cartItemList[
                                                                    index]);
                                                        print(
                                                            'decremnt is -> ${cartController.cartItemList[index].quantity}');
                                                      },
                                                      child:
                                                          Icon(Icons.remove)),
                                                ],
                                              ),
                                            )),
                                        GestureDetector(
                                          onTap: () {
                                            cartController.removeToCart(
                                                cartController
                                                    .cartItemList[index]);
                                          },
                                          child: Icon(
                                            Icons.delete_outlined,
                                            size: 21.sp,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.sp),
                    topLeft: Radius.circular(20.sp)),
                child: Container(
                  height: 30.h,
                  width: 100.w,
                  color: ColorConstant.primaryColorLightGrey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 14.0.sp, horizontal: 20.sp),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal', style: TextStyle(fontSize: 12.sp)),
                            Text(
                              // '\$30',
                              "\$ ${cartController.countTotal()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax & Fees',
                                style: TextStyle(fontSize: 12.sp)),
                            Text(
                              " \$ ${cartController.taxFees().toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery', style: TextStyle(fontSize: 12.sp)),
                            Text(
                              'Free',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TOTAL',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              " \$ ${cartController.total().toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.sp),
                          child: Container(
                            height: 5.5.h,
                            width: 86.w,
                            color: ColorConstant.primaryColorRed,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Get.showSnackbar(GetSnackBar(
                                    message: 'Thank you For Your Visit !😀',
                                    duration: Duration(seconds: 3),
                                  ));
                                },
                                child: Text(
                                  'CHACKOUT',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
