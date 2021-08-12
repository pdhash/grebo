import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/createPostController.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/shared/alertdialogue.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/postview.dart';

class CreatePost extends StatelessWidget {
  final PostController postController = Get.put(PostController());
  final TextEditingController postCaption = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (PostController controller) {
        return Scaffold(
          appBar: appBar('create_post'.tr, [
            Padding(
              padding: const EdgeInsets.only(right: 18, top: 5),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showCustomDialog(
                        context: context,
                        height: 160,
                        content: 'post_msg'.tr,
                        contentSize: 15,
                        onTap: () {
                          Get.back();
                        },
                        color: AppColor.kDefaultColor,
                        okText: 'go_to_home'.tr);
                  },
                  icon: Text(
                    'post'.tr,
                    style: TextStyle(
                        color: AppColor.kDefaultFontColor,
                        fontSize: getProportionateScreenWidth(16)),
                  )),
            )
          ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Row(
                    children: [
                      buildCircleProfile(
                          height: 57,
                          width: 57,
                          image: AppImages.defaultProfile),
                      getHeightSizedBox(w: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Business Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(18),
                            ),
                          ),
                          getHeightSizedBox(h: 6),
                          Text(
                            'Health Care',
                            style: TextStyle(
                              color:
                                  AppColor.kDefaultFontColor.withOpacity(0.75),
                              fontSize: getProportionateScreenWidth(15),
                            ),
                          ),
                          getHeightSizedBox(h: 6),
                          Text(
                            'Managed By: Samira Sehgal',
                            style: TextStyle(
                              color:
                                  AppColor.kDefaultFontColor.withOpacity(0.85),
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                getHeightSizedBox(h: 18),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
                //getHeightSizedBox(h: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: TextFormField(
                    controller: postCaption,
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(
                        height: 1.5, fontSize: getProportionateScreenWidth(14)),
                    textCapitalization: TextCapitalization.sentences,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'what_do_you..'.tr,
                        hintStyle: TextStyle(
                            fontSize: getProportionateScreenWidth(16))),
                  ),
                ),
                getHeightSizedBox(h: 10),
                controller.image == null
                    ? SizedBox(
                        height: getProportionateScreenWidth(130),
                      )
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Container(
                              width: getProportionateScreenWidth(325),
                              height: getProportionateScreenWidth(130),
                              child: Image.file(
                                File(controller.image.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              right: -7,
                              top: -7,
                              child: GestureDetector(
                                  onTap: () {
                                    controller.image = null;
                                  },
                                  child: buildWidget(AppImages.close, 20, 20)))
                        ],
                      ),
                getHeightSizedBox(h: 15),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
                getHeightSizedBox(h: 5),
                Row(
                  children: [
                    Spacer(),
                    imageButtons(
                        title: 'take_a_photo'.tr,
                        image: AppImages.photo,
                        onTap: () {
                          postController.openBottomSheet(
                              context: context, isVideo: false);
                        }),
                    Spacer(),
                    SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                      ),
                    ),
                    Spacer(),
                    imageButtons(
                        title: 'take_a_video'.tr,
                        image: AppImages.video,
                        onTap: () {
                          postController.openBottomSheet(
                              context: context, isVideo: true);
                        }),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget imageButtons(
    {required String title, required String image, Function()? onTap}) {
  return MaterialButton(
    padding: EdgeInsets.zero,
    onPressed: onTap,
    child: Row(
      children: [
        buildWidget(image, 16, 23),
        getHeightSizedBox(w: 5),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: TextStyle(fontSize: getProportionateScreenWidth(14)),
          ),
        ),
      ],
    ),
  );
}
