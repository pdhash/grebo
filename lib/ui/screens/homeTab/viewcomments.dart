import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/commentview.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:greboo/ui/shared/postdetailbottom.dart';

class ViewComments extends StatelessWidget {
  final int currentPost;
  final TextEditingController comment = TextEditingController();
  final HomeScreenController homeScreenController = Get.find();

  ViewComments({Key? key, required this.currentPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('comments'.tr),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: List.generate(
                      homeScreenController.list[currentPost]['comment'].length,
                      (index) =>
                          CommentView(currentPost: currentPost, index: index)),
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
              child: true != true
                  ? PostDetailsBottomView(
                      comment: comment,
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
