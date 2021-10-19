import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/controller/postDetailController.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/homeTab/viewcomments.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/commentview.dart';
import 'package:grebo/ui/shared/postdetailbottom.dart';
import 'package:grebo/ui/shared/postview.dart';

import 'model/postModel.dart';

class PostDetails extends StatelessWidget {
  final PostDetailController postDetailController =
      Get.put(PostDetailController());
  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController comment = TextEditingController();
  final PostData postData;
  PostDetails({Key? key, required this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('post_details'.tr),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  PostView(
                    postData: postData,
                  ),
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
                            GetBuilder(
                              builder: (HomeController controller) =>
                                  postData.comment == 0
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            disposeKeyboard();

                                            Get.to(() => ViewComments(
                                                  postData: postData,
                                                ));
                                          },
                                          child: Text(
                                            'view_all_comments'.tr,
                                            style: TextStyle(
                                                color: AppColor
                                                    .kDefaultFontColor
                                                    .withOpacity(0.6),
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        14)),
                                          ),
                                        ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  getHeightSizedBox(h: 5),
                  GetBuilder(
                    builder: (HomeController controller) =>
                        postData.comment == 0
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
                                          fontSize:
                                              getProportionateScreenWidth(20)),
                                    )
                                  ],
                                ),
                              )
                            : GetBuilder(
                                builder: (PostDetailController controller) =>
                                    controller.last2Comments.length == 0
                                        ? SizedBox(
                                            height: 100,
                                            child: Center(
                                              child: GetPlatform.isAndroid
                                                  ? CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    )
                                                  : CupertinoActivityIndicator(),
                                            ))
                                        : Column(
                                            children: List.generate(
                                                controller.last2Comments.length,
                                                (index) => CommentView(
                                                      commentsData: controller
                                                          .last2Comments[index],
                                                    )),
                                          ),
                              ),
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
                  send: () {
                    if (comment.text.isNotEmpty) {
                      disposeKeyboard();
                      postDetailController.commentText = comment.text.trim();
                      comment.clear();

                      postDetailController.addComments(postData);
                    }
                  },
                  isAddRequired: true,
                ))
          ],
        ));
  }
}
