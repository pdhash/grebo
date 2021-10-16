import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/dateTimeFormatExtension.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/businessprofile.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';
import 'package:grebo/ui/screens/homeTab/postdetails.dart';
import 'package:grebo/ui/screens/homeTab/viewcomments.dart';
import 'package:readmore/readmore.dart';

class PostView extends StatelessWidget {
  final PostData postData;
  final HomeController homeScreenController = Get.find<HomeController>();

  PostView({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return Column(
        children: [
          getHeightSizedBox(h: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileImageView(),
                getHeightSizedBox(w: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      homeScreenController.currentPostRef = postData.id;

                      Get.to(() => PostDetails(
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
                                Get.to(() => BusinessProfile(
                                      user: userController.user,
                                    ));
                              },
                              child: Text(
                                postData.postUserDetail.name,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(16),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            getHeightSizedBox(w: 5),
                            buildWidget(
                                postData.postUserDetail.verifiedByAdmin
                                    ? AppImages.verified
                                    : AppImages.warning,
                                20,
                                20)
                          ],
                        ),
                        getHeightSizedBox(h: 5),
                        Text(
                          DateTimeFormatExtension
                              .displayTimeFromTimestampForPost(
                                  postData.createdAt.toLocal()),
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              color:
                                  AppColor.kDefaultFontColor.withOpacity(0.57)),
                        ),
                        postData.video == "" && postData.image == ""
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: FadeInImage(
                                    placeholder:
                                        AssetImage(AppImages.placeHolder),
                                    image: postData.image == ""
                                        ? NetworkImage(
                                            "${imageUrl + postData.thumbnail}")
                                        : NetworkImage(
                                            "${imageUrl + postData.image}"),
                                    height: 138,
                                    width: 281,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        AppImages.placeHolder,
                                        height: 138,
                                        width: 281,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                        getHeightSizedBox(h: 3),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                disposeKeyboard();
                                homeScreenController.likeUpdate(postData);

                                //Get.to(() => LikeError());
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(3),
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
                            ),
                            getHeightSizedBox(w: 20),
                            GestureDetector(
                                onTap: () {
                                  disposeKeyboard();
                                  Get.to(() => ViewComments(
                                        postData: postData,
                                      ));
                                  homeScreenController.currentPostRef =
                                      postData.id;
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.all(3),
                                  child: Row(
                                    children: [
                                      buildWidget(AppImages.comment, 15, 16),
                                      getHeightSizedBox(w: 5),
                                      Text(
                                        postData.comment.toString(),
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        getHeightSizedBox(h: 7),
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
    });
  }

  GestureDetector profileImageView() {
    return GestureDetector(
      onTap: () {
        Get.to(() => BusinessProfile(
              user: userController.user,
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: FadeInImage(
          placeholder: AssetImage(AppImages.placeHolder),
          image: userController.user.userType ==
                  getServiceTypeCode(ServicesType.providerType)
              ? NetworkImage("${imageUrl + userController.user.picture}")
              : NetworkImage("${imageUrl + postData.postUserDetail.picture}"),
          height: 44,
          width: 44,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AppImages.placeHolder,
              height: 44,
              width: 44,
              fit: BoxFit.cover,
            );
          },
          fit: BoxFit.cover,
        ),
      ),
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
