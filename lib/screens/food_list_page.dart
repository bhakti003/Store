import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_store/constant.dart';
import 'package:food_store/controller/dashboardController.dart';
import 'package:food_store/model/item_data_model.dart';
import 'package:food_store/screens/food_details_page.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage>
    with TickerProviderStateMixin {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(35.sp)),
                child: Container(
                  height: 72.h,
                  width: 100.w,
                  color: ColorConstant.primaryColorLightGrey,
                )),
            Column(children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.0.sp, horizontal: 14.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 6.5.h,
                          height: 6.5.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstant.primaryColorGrey,
                          ),
                          child: Obx(
                            () =>
                                dashBoardController.userData.value.profileUrl !=
                                        ''
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
                                    : Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.sp,
                    ),
                    Text(
                      "Let's Find ",
                      style: TextConstant.primaryText,
                    ),
                    Text(
                      'Somthing Delicious!',
                      style: TextConstant.primaryText,
                    ),
                    SizedBox(
                      height: 24.sp,
                    ),
                    TextFormField(
                      controller: dashBoardController.searchController,
                      decoration: InputDecoration(
                          fillColor: ColorConstant.primaryColorWhite,
                          filled: true,
                          prefixIcon: Icon(Icons.search,
                              color: ColorConstant.primaryColorGrey),
                          hintText: 'Search catagoris...',
                          hintStyle: TextStyle(
                              color: ColorConstant.primaryColorGrey,
                              fontSize: 11.sp),
                          suffixIcon: Icon(
                            Icons.tune,
                            color: ColorConstant.primaryColorGrey,
                          ),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: BorderSide.none)),
                    ),
                    SizedBox(
                      height: 16.sp,
                    ),
                    DefaultTabController(
                      length: 4,
                      child: TabBar(
                        tabs: [
                          Text('Foods'),
                          Text('Drinks'),
                          Text('Snacks'),
                          Text('Sauce'),
                        ],
                        controller: tabController,
                        indicatorColor: ColorConstant.primaryColorRed,
                        indicatorWeight: 2,
                        labelColor: ColorConstant.primaryColorRed,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: EdgeInsets.symmetric(vertical: 8.sp),
                        unselectedLabelColor: ColorConstant.primaryColorGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 52.sp,
                ),
                child: SizedBox(
                  height: 40.5.h,
                  child: TabBarView(
                    children: [
                      ListItemWidget(
                        itemList: dashBoardController.foodList,
                      ),
                      ListItemWidget(
                        itemList: dashBoardController.drinkList,
                      ),
                      ListItemWidget(
                        itemList: dashBoardController.snacksList,
                      ),
                      ListItemWidget(
                        itemList: dashBoardController.sauceList,
                      ),
                    ],
                    controller: tabController,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  RxList<ItemData>? itemList;
  ListItemWidget({
    this.itemList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemList!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Obx(
            () => Stack(
              children: [
                Positioned(
                  top: 8.h,
                  left: 12.sp,
                  child: Container(
                    height: 32.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstant.primaryColorWhite,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1.5.sp,
                              blurRadius: 2.5.sp,
                              color: ColorConstant.primaryColorLightGrey)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(top: 80.sp),
                      child: Column(
                        children: [
                          Text(itemList![index].itemName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19.sp,
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            "\$${itemList![index].itemPrice}",
                            style: TextStyle(
                                color: ColorConstant.primaryColorRed,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 38.0, right: 33.0, top: 2),
                  child: Container(
                    height: 20.h,
                    width: 20.h,
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => FoodDetailsPage(
                                itemDetails: itemList![index],
                              ));
                        },
                        child: CachedNetworkImage(
                          imageUrl: itemList![index].itemurl ?? '',
                          // progressIndicatorBuilder:
                          //     (context, url, downloadProgress) =>
                          //         CircularProgressIndicator(
                          //             value: downloadProgress.progress,
                          //             color: ColorConstant.primaryColorRed),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 20.h,
                          width: 20.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.primaryColorWhite,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2.sp,
                              blurRadius: 3.sp,
                              color: ColorConstant.primaryColorLightGrey)
                        ]),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
