import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/homeController.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/commentview.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/postdetailbottom.dart';

import '../../../main.dart';
import 'home.dart';

class ViewComments extends StatelessWidget {
  final int currentPost;
  final TextEditingController comment = TextEditingController();
  final HomeController homeScreenController = Get.find<HomeController>();
  // final ServiceController serviceController = Get.find<ServiceController>();

  ViewComments({Key? key, required this.currentPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(currentPost);
    return Scaffold(
      appBar: appBar('comments'.tr),
      body: Stack(
        fit: StackFit.expand,
        children: [
          list[currentPost]['comment'] == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                            list[currentPost]['comment'].length,
                            (index) => CommentView(
                                currentPost: currentPost, index: index)),
                      ),
                      SizedBox(
                        height: 230,
                      )
                    ],
                  ),
                ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: userController.user.userType == 1
                  ? PostDetailsBottomView(
                      comment: comment,
                      hintText: 'textfieldmsg1'.tr,
                      send: () {},
                    )
                  : Container(
                      color: Color(0xffF9F9F9),
                      child: Column(
                        children: [
                          getHeightSizedBox(h: 26),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Text(
                              'like_error'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16)),
                            ),
                          ),
                          getHeightSizedBox(h: 17),
                          SafeArea(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: CustomButton(
                                  type: CustomButtonType.colourButton,
                                  text: 'view_profile'.tr,
                                  onTap: () {}),
                            ),
                          ),
                          getHeightSizedBox(h: 17),
                        ],
                      ),
                    ))
        ],
      ),
    );
  }
}
