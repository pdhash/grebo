import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/commentview.dart';
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
              child: PostDetailsBottomView(
                comment: comment,
                send: () {},
              ))
        ],
      ),
    );
  }
}
