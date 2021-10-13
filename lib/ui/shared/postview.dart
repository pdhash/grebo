import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/businessprofile.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';
import 'package:grebo/ui/screens/homeTab/postdetails.dart';
import 'package:grebo/ui/screens/homeTab/provider/likeerror.dart';
import 'package:grebo/ui/screens/homeTab/viewcomments.dart';
import 'package:readmore/readmore.dart';

class PostView extends StatelessWidget {
  final int index;
  final PostData postData;
  final HomeController homeScreenController = Get.find<HomeController>();

  PostView({Key? key, required this.index, required this.postData})
      : super(key: key);

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
              GestureDetector(
                onTap: () {
                  Get.to(() => BusinessProfile());
                },
                child: buildCircleProfile(
                    image: imageUrl + "${postData.postUserDetail.picture}",
                    height: 44,
                    width: 44),
              ),
              getHeightSizedBox(w: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => PostDetails(
                          indexx: index,
                          postData: postData,
                        ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getHeightSizedBox(h: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => BusinessProfile());
                            },
                            child: Text(
                              postData.postUserDetail.name,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16),
                                  fontWeight: FontWeight.bold),
                            ),
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
                            color:
                                AppColor.kDefaultFontColor.withOpacity(0.57)),
                      ),
                      postData.video == ""
                          ? SizedBox()
                          : Container(
                              height: 138,
                              width: 281,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${imageUrl + postData.postUserDetail.picture}"),
                                      fit: BoxFit.fill)),
                            ),
                      postData.text == ""
                          ? getHeightSizedBox(h: 5)
                          : getHeightSizedBox(h: 10),
                      postData.text == ""
                          ? SizedBox()
                          : ReadMoreText(
                              postData.text,
                              trimLines: 3,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                fontFamily: 'Nexa',
                                color: AppColor.kDefaultFontColor
                                    .withOpacity(0.89),
                              ),
                              lessStyle: TextStyle(
                                  color: AppColor.kDefaultFontColor,
                                  fontSize: getProportionateScreenWidth(14),
                                  fontWeight: FontWeight.bold),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'see_all'.tr,
                              trimExpandedText: 'see_less'.tr,
                              moreStyle: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  fontWeight: FontWeight.bold),
                            ),
                      Divider(),
                      getHeightSizedBox(h: 6),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              disposeKeyboard();
                              Get.to(() => LikeError());
                            },
                            child: Row(
                              children: [
                                buildWidget(
                                    postData.isLike
                                        ? AppImages.like
                                        : AppImages.unlike,
                                    15,
                                    17),
                                getHeightSizedBox(w: 5),
                                Text(
                                  postData.like.toString(),
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(12)),
                                ),
                              ],
                            ),
                          ),
                          getHeightSizedBox(w: 23),
                          GestureDetector(
                              onTap: () {
                                disposeKeyboard();
                                Get.to(() => ViewComments(currentPost: index));
                              },
                              child: Row(
                                children: [
                                  buildWidget(AppImages.comment, 15, 16),
                                  getHeightSizedBox(w: 5),
                                  Text(
                                    postData.comment.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12)),
                                  ),
                                ],
                              )),
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

Widget buildCircleProfile(
    {required String image, required double height, required double width}) {
  return Container(
    height: getProportionateScreenWidth(height),
    width: getProportionateScreenWidth(width),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
  );
}

Widget uploadProfile(
    {required String image, required double height, required double width}) {
  return Container(
    height: getProportionateScreenWidth(height),
    width: getProportionateScreenWidth(width),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            DecorationImage(image: FileImage(File(image)), fit: BoxFit.cover)),
  );
}
