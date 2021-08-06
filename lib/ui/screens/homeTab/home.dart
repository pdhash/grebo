import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:greboo/ui/screens/homeTab/viewAllCategories.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:greboo/ui/shared/postview.dart';

class Homes extends StatelessWidget {
  final HomeScreenController homeScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
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
                        color: AppColor.kDefaultFontColor.withOpacity(0.75)),
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
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              Text(
                'business_categories'.tr,
                style: TextStyle(fontSize: getProportionateScreenWidth(16)),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => ViewAll());
                },
                child: Text(
                  'view_all'.tr,
                  style: TextStyle(fontSize: getProportionateScreenWidth(14)),
                ),
              )
            ],
          ),
        ),
        getHeightSizedBox(h: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: kDefaultPadding),
            child: Row(
              children: homeScreenController.categories
                  .map((e) => BusinessCategories(
                        text: e,
                        textStyle: TextStyle(
                            fontSize: getProportionateScreenWidth(13),
                            color: AppColor.kDefaultFontColor),
                        onTap: () {},
                        height: 38,
                        backgroundColor: Colors.white,
                        border: Border.all(
                            color: AppColor.categoriesColor, width: 1),
                      ))
                  .toList(),
            ),
          ),
        ),
        getHeightSizedBox(h: 10),
        Divider(
          height: 0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: homeScreenController.list.length,
            itemBuilder: (context, index) {
              return PostView(index: index);
            },
          ),
        ),
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
