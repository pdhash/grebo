import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/baseScreen/controller/createPostController.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/alertdialogue.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/postview.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final AddPostController postController = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AddPostController controller) {
        return GestureDetector(
          onTap: () {
            disposeKeyboard();
          },
          child: Scaffold(
            appBar: appBar('create_post'.tr, [
              Padding(
                padding: const EdgeInsets.only(right: 18, top: 5),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      disposeKeyboard();
                      if (controller.uploadFile != null ||
                          controller.postCaption.text.isNotEmpty) {
                        controller.addPost().then((value) {
                          if (value != null) {
                            Home.paginationViewKey.currentState!.refresh();
                            showCustomDialog(
                                context: Get.context as BuildContext,
                                height: 160,
                                content: 'post_msg'.tr,
                                contentSize: 15,
                                onTap: () {
                                  Get.back();
                                  Get.back();
                                },
                                color: AppColor.kDefaultColor,
                                okText: 'go_to_home'.tr);
                          }
                        });
                      }
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
                            image: "${imageUrl + userController.user.picture}"),
                        getHeightSizedBox(w: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userController.user.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(18),
                              ),
                            ),
                            getHeightSizedBox(h: 6),
                            Text(
                              userController.user.categories
                                  .map((e) => e.name)
                                  .toList()
                                  .join(","),
                              style: TextStyle(
                                color: AppColor.kDefaultFontColor
                                    .withOpacity(0.75),
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                            getHeightSizedBox(h: 6),
                            Text(
                              '${"managed_by".tr} : ${userController.user.businessName}',
                              style: TextStyle(
                                color: AppColor.kDefaultFontColor
                                    .withOpacity(0.85),
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
                      controller: controller.postCaption,
                      textInputAction: TextInputAction.done,
                      minLines: 1,
                      maxLines: 5,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: getProportionateScreenWidth(14)),
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
                  controller.uploadFile == null
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
                                child: controller.isImage == 2
                                    ? Image.file(
                                        controller.uploadFile as File,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        controller.thumbnail as File,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                                right: -5,
                                top: -5,
                                child: GestureDetector(
                                    onTap: () {
                                      controller.isImage = 0;
                                      controller.uploadFile = null;
                                      controller.thumbnail = null;
                                    },
                                    child:
                                        buildWidget(AppImages.close, 20, 20)))
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
                          onTap: () async {
                            postController.openBottomSheet(
                                context: context, isVideo: true);
                          }),
                      Spacer(),
                    ],
                  )
                ],
              ),
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
