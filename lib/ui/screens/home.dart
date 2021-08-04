import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:greboo/ui/screens/postdetails.dart';
import 'package:greboo/ui/screens/viewAllCategories.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:readmore/readmore.dart';

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
        Divider(),
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
class PostView extends StatelessWidget {
  final int index;
  final HomeScreenController homeScreenController=Get.find();

   PostView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getHeightSizedBox(h: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenWidth(44),
                width: getProportionateScreenWidth(44),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(AppImages.defaultProfile))),
              ),
              getHeightSizedBox(w: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => PostDetails(
                      index: index,
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getHeightSizedBox(h: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Business Name',
                            style: TextStyle(
                                fontSize:
                                getProportionateScreenWidth(16),
                                fontWeight: FontWeight.bold),
                          ),
                          getHeightSizedBox(w: 5),
                          buildWidget(AppImages.warning, 20, 20)
                        ],
                      ),
                      getHeightSizedBox(h: 5),
                      Text(
                        '12h',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: AppColor.kDefaultFontColor
                                .withOpacity(0.57)),
                      ),
                      homeScreenController.list[index]['image'] ==
                          null
                          ? SizedBox()
                          : getHeightSizedBox(h: 10),
                      homeScreenController.list[index]['image'] ==
                          null
                          ? SizedBox()
                          : Container(
                        height: 138,
                        width: 281,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(11),
                            image: DecorationImage(
                                image: AssetImage(
                                    homeScreenController
                                        .list[index]['image']),
                                fit: BoxFit.fill)),
                      ),
                      homeScreenController.list[index]['title'] ==
                          null
                          ? getHeightSizedBox(h: 5)
                          : getHeightSizedBox(h: 10),
                      homeScreenController.list[index]['title'] ==
                          null
                          ? SizedBox()
                          : ReadMoreText(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is dummy text of the & typesetting industry',
                        trimLines: 3,
                        style: TextStyle(
                          fontSize:
                          getProportionateScreenWidth(14),
                          fontFamily: 'Nexa',
                          color: AppColor.kDefaultFontColor
                              .withOpacity(0.89),
                        ),
                        lessStyle: TextStyle(
                          color: AppColor.kDefaultFontColor,
                          fontSize:
                          getProportionateScreenWidth(14),
                        ),
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'see_all'.tr,
                        trimExpandedText: 'see_less'.tr,
                        moreStyle: TextStyle(
                            fontSize:
                            getProportionateScreenWidth(14),
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      getHeightSizedBox(h: 6),
                      Row(
                        children: [
                          buildWidget(AppImages.like, 15, 17),
                          getHeightSizedBox(w: 5),
                          Text(
                            '12700',
                            style: TextStyle(
                                fontSize:
                                getProportionateScreenWidth(12)),
                          ),
                          getHeightSizedBox(w: 23),
                          buildWidget(AppImages.comment, 15, 16),
                          getHeightSizedBox(w: 5),
                          Text(
                            '300',
                            style: TextStyle(
                                fontSize:
                                getProportionateScreenWidth(12)),
                          ),
                        ],
                      ),
                      getHeightSizedBox(h: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
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
