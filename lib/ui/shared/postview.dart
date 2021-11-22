import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/dateTimeFormatExtension.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/businessprofile.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/controller/postDetailController.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';
import 'package:grebo/ui/screens/homeTab/postdetails.dart';
import 'package:grebo/ui/screens/homeTab/videoScreen.dart';
import 'package:grebo/ui/screens/homeTab/viewcomments.dart';
import 'package:grebo/ui/screens/homeTab/widget/guestLoginScreen.dart';
import 'package:readmore/readmore.dart';

class PostView extends StatelessWidget {
  final PostData postData;
  final HomeController homeScreenController = Get.find<HomeController>();
  final bool isPostDetail;

  PostView({
    Key? key,
    required this.postData,
    this.isPostDetail = false,
  }) : super(key: key);

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
              profileImageView(),
              getHeightSizedBox(w: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isPostDetail == false) {
                      homeScreenController.currentPostRef = postData.id;
                      Get.to(() => PostDetails(
                            postRef: postData.id,
                          ));
                    }
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
                              if (userController.isGuest) {
                                Get.to(() => GuestLoginScreen());
                                return;
                              }
                              print(postData.userRef);
                              Get.to(() => BusinessProfile(
                                    businessRef: postData.userRef,
                                  ));
                            },
                            child: Text(
                              postData.postUserDetail.businessName,
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
                        DateTimeFormatExtension.displayTimeFromTimestampForPost(
                            postData.createdAt.toLocal()),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color:
                                AppColor.kDefaultFontColor.withOpacity(0.57)),
                      ),
                      postData.video == "" && postData.image == ""
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                if (isPostDetail) {
                                  if (postData.image == "") {
                                    print("ok");
                                    Get.to(() => VideoScreen(
                                        path: "${videoUrl + postData.video}"));
                                  }
                                } else {
                                  homeScreenController.currentPostRef =
                                      postData.id;
                                  Get.to(() => PostDetails(
                                        postRef: postData.id,
                                      ));
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
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
                                  postData.image == ""
                                      ? SvgPicture.asset(AppImages.videoPlay)
                                      : SizedBox()
                                ],
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
                              if (userController.isGuest) {
                                Get.to(() => GuestLoginScreen());
                                return;
                              }
                              homeScreenController.currentPostRef = postData.id;

                              if (isPostDetail) {
                                final postDetailController =
                                    Get.find<PostDetailController>();

                                postDetailController.postDataModel.isLike =
                                    !postDetailController.postDataModel.isLike;

                                if (postDetailController.postDataModel.isLike) {
                                  postDetailController.postDataModel.like += 1;
                                } else {
                                  postDetailController.postDataModel.like -= 1;
                                }
                                homeScreenController.likeUpdate(postData);

                                postDetailController.update();

                                PostRepo.likeUpdate(
                                    postDetailController.postDataModel.id,
                                    postDetailController.postDataModel.isLike);
                              } else {
                                homeScreenController.likeUpdate(postData);
                                PostRepo.likeUpdate(
                                    postData.id, postData.isLike);
                              }
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
                                if (userController.isGuest) {
                                  Get.to(() => GuestLoginScreen());
                                  return;
                                }
                                homeScreenController.currentPostRef =
                                    postData.id;

                                Get.to(() => ViewComments(
                                      postData: postData,
                                    ));
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
                                              getProportionateScreenWidth(12)),
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
  }

  GestureDetector profileImageView() {
    return GestureDetector(
      onTap: () {
        if (userController.isGuest) {
          Get.to(() => GuestLoginScreen());
          return;
        }
        Get.to(() => BusinessProfile(
              businessRef: postData.userRef,
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
