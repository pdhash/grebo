import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/controller/postDetailController.dart';
import 'package:grebo/ui/screens/homeTab/model/commentModel.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/commentview.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/postdetailbottom.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../../main.dart';
import 'home.dart';
import 'model/postModel.dart';

class ViewComments extends StatelessWidget {
  final PostData postData;
  final TextEditingController comment = TextEditingController();
  final PostDetailController postDetailController =
      Get.put(PostDetailController());

  ViewComments({Key? key, required this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('comments'.tr),
      body: Stack(
        fit: StackFit.expand,
        children: [
          postData.comment == 0
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
              : GetBuilder(
                  builder: (HomeController controller) {
                    print("GET BUILDER CALLING");
                    return PaginationView(
                        padding: EdgeInsets.only(bottom: 100),
                        scrollController:
                            ScrollController(initialScrollOffset: 10),
                        pullToRefresh: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context,
                            CommentsData commentData, int index) {
                          return CommentView(
                            commentsData: commentData,
                          );
                        },
                        pageFetch: postDetailController.fetchComments,
                        onError: (dynamic error) => Center(child: Text(error)),
                        onEmpty: Center(
                          child: Text("no_post_found".tr),
                        ),
                        initialLoader: GetPlatform.isAndroid
                            ? Center(child: CircularProgressIndicator())
                            : Center(child: CupertinoActivityIndicator()));
                  },
                ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: userController.user.profileCompleted
                  ? PostDetailsBottomView(
                      comment: comment,
                      hintText: 'textfieldmsg1'.tr,
                      send: () {
                        if (comment.text.isNotEmpty) {
                          disposeKeyboard();
                          postDetailController.commentText =
                              comment.text.trim();
                          comment.clear();
                          postDetailController.addComments(postData);
                        }
                      },
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
