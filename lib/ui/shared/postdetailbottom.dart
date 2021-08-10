import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/utils/config.dart';

import 'customtextfield.dart';

class PostDetailsBottomView extends StatelessWidget {
  final TextEditingController comment;
  final Function()? send;
  final String hintText;
  final bool isAddRequired;

  const PostDetailsBottomView(
      {Key? key,
      required this.comment,
      this.send,
      required this.hintText,
      this.isAddRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 0.2,
            width: Get.width,
            color: Color(0xff707070).withOpacity(0.7),
          ),
          getHeightSizedBox(h: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField2(
              comment: comment,
              hintText: hintText,
              send: send,
            ),
          ),
          getHeightSizedBox(h: 15),
          isAddRequired
              ? Container(
                  height: 50,
                  width: Get.width,
                  color: Colors.red,
                  child: Center(child: Text('Advertisment')),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
