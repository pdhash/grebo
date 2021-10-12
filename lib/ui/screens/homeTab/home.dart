import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';
import 'package:grebo/ui/screens/homeTab/viewAllCategories.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/postview.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../../main.dart';

class Home extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        userController.user.userType ==
                getServiceTypeCode(ServicesType.userType)
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        buildWidget(AppImages.location, 18, 13),
                        SizedBox(
                          width: getProportionateScreenWidth(9),
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(250),
                            height: 18,
                            child: Text(
                              'yogeshwar soc society,shyamdham chowk, surat',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  color: AppColor.kDefaultFontColor
                                      .withOpacity(0.75)),
                            )),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'change'.tr,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  getHeightSizedBox(h: 16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        Text(
                          'business_categories'.tr,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16)),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ViewAll());
                          },
                          child: Text(
                            'view_all'.tr,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(14)),
                          ),
                        )
                      ],
                    ),
                  ),
                  getHeightSizedBox(h: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(left: kDefaultPadding),
                      child: Row(
                        children: categories
                            .map((e) => BusinessCategories(
                                  text: e,
                                  textStyle: TextStyle(
                                      fontSize: getProportionateScreenWidth(13),
                                      color: AppColor.kDefaultFontColor),
                                  onTap: () {},
                                  height: 38,
                                  backgroundColor: Colors.white,
                                  border: Border.all(
                                      color: AppColor.categoriesColor,
                                      width: 1),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  getHeightSizedBox(h: 10),
                  Divider(
                    height: 0,
                  ),
                ],
              )
            : SizedBox(),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: list.length,
        //     physics: BouncingScrollPhysics(),
        //     itemBuilder: (context, index) {
        //       return PostView(index: index);
        //     },
        //   ),
        // ),
        Expanded(
            child: PaginationView(
          itemBuilder: (BuildContext context, PostData postData, int index) {
            return PostView(
              index: index,
              postData: postData,
            );
          },
          pullToRefresh: true,
          pageFetch: homeController.fetchMyPost,
          onEmpty: Center(
            child: Text('no_post_found'.tr),
          ),
          onError: (error) {
            return Center(child: Text(error));
          },
        ))
      ],
    );
  }
}

Widget buildWidget(String image, double height, double width) {
  return Container(
    height: getProportionateScreenWidth(height),
    width: getProportionateScreenWidth(width),
    child: SvgPicture.asset(
      image,
      fit: BoxFit.fill,
    ),
  );
}
