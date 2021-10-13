import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/shared/postview.dart';

class CommentView extends StatelessWidget {
  final HomeController homeScreenController = Get.find<HomeController>();
  final int currentPost;
  final int index;

  CommentView({Key? key, required this.currentPost, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getHeightSizedBox(h: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: AppColor.kDefaultFontColor.withOpacity(0.07),
                    offset: Offset(0, 1),
                    blurRadius: 6)
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                getHeightSizedBox(h: 15),
                Row(
                  children: [
                    buildCircleProfile(
                        image: list[currentPost]['comment'][index]['profile'],
                        height: 40,
                        width: 40),
                    getHeightSizedBox(w: 9),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[currentPost]['comment'][index]['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                          getHeightSizedBox(h: 5),
                          Text(
                            list[currentPost]['comment'][index]['time'],
                            style: TextStyle(
                                color: AppColor.kDefaultFontColor
                                    .withOpacity(0.57),
                                fontSize: getProportionateScreenWidth(13)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                getHeightSizedBox(h: 7),
                Text(
                  list[currentPost]['comment'][index]['title'],
                  style: TextStyle(
                      color: AppColor.kDefaultFontColor.withOpacity(0.89),
                      fontSize: getProportionateScreenWidth(14)),
                ),
                getHeightSizedBox(h: 16),
              ],
            ),
          ),
        ),
        getHeightSizedBox(h: 5),
      ],
    );
  }
}
