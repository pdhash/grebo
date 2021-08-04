import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:greboo/ui/shared/appbar.dart';

import 'home.dart';

class PostDetails extends StatelessWidget {
  final int index;
  final HomeScreenController homeScreenController = Get.find();
  final TextEditingController comment = TextEditingController();
  PostDetails({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('post_details'.tr),
        body: Column(
          children: [
            PostView(index: index),
            getHeightSizedBox(h: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                      Text(
                        'view_all_comments'.tr,
                        style: TextStyle(
                            color: AppColor.kDefaultFontColor.withOpacity(0.6),
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                    ],
                  ),
                  CustomTextField2(
                    comment: comment,
                    hintText: 'Leave your comments here...',
                  )
                ],
              ),
            ),
            getHeightSizedBox(h: 18),
          ],
        ));
  }
}

class CustomTextField2 extends StatelessWidget {
  final TextEditingController comment;
  final String hintText;

  const CustomTextField2(
      {Key? key, required this.comment, required this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(43),
      alignment: Alignment.center,
      child: TextField(
        controller: comment,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
            fillColor: AppColor.textField2Color,
            filled: true,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
