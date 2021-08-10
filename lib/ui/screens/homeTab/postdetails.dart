import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/screens/homeTab/viewcomments.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/commentview.dart';
import 'package:greboo/ui/shared/postdetailbottom.dart';
import 'package:greboo/ui/shared/postview.dart';

class PostDetails extends StatelessWidget {
  final int indexx;
  final HomeScreenController homeScreenController = Get.find();
  final TextEditingController comment = TextEditingController();
  PostDetails({Key? key, required this.indexx}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('post_details'.tr),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  PostView(index: indexx),
                  getHeightSizedBox(h: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'comments'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenWidth(16)),
                            ),
                            Spacer(),
                            homeScreenController.list[indexx]['comment'] == null
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          ViewComments(currentPost: indexx));
                                    },
                                    child: Text(
                                      'view_all_comments'.tr,
                                      style: TextStyle(
                                          color: AppColor.kDefaultFontColor
                                              .withOpacity(0.6),
                                          fontSize:
                                              getProportionateScreenWidth(14)),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  getHeightSizedBox(h: 5),
                  homeScreenController.list[indexx]['comment'] == null
                      ? Container(
                          height: 200,
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildWidget(AppImages.noComment, 20, 21.34),
                              Text(
                                'no_comments'.tr,
                                style: TextStyle(
                                    color: Color(0xff969696),
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(20)),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: List.generate(
                              homeScreenController
                                  .list[indexx]['comment'].length,
                              (index) => CommentView(
                                    currentPost: indexx,
                                    index: index,
                                  )),
                        ),
                  SizedBox(
                    height: 130,
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: PostDetailsBottomView(
                  comment: comment,
                  hintText: 'textfieldmsg1'.tr,
                  send: () {},
                  isAddRequired: true,
                ))
          ],
        ));
  }
}
