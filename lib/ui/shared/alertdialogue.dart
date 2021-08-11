import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';

import 'customtextfield.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required double height,
  String? title,
  required Widget content,
  required Function()? onTap,
  required Color color,
  required String okText,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)), //this right here
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            height: height,
            child: Column(
              children: [
                Spacer(
                  flex: 2,
                ),
                title == null
                    ? SizedBox()
                    : Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: content,
                ),
                Spacer(
                  flex: 2,
                ),
                SizedBox(
                  height: getProportionateScreenWidth(45),
                  width: double.infinity,
                  child: MaterialButton(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: onTap,
                    child: Text(
                      okText,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// ----------------------------------------------------
Future<void> dialogueOpen(
    {context,
    Function()? onOk,
    Function()? onCancel,
    required TextEditingController controller}) async {
  Widget getButtons(
      {Function()? onTap,
      required String text,
      Color color = AppColor.kDefaultColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: getProportionateScreenWidth(15)),
      ),
    );
  }

  return showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: FittedBox(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'enter_website_url'.tr,
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(18)),
                    ),
                    getHeightSizedBox(h: 20),
                    CustomTextField(
                        controller: controller,
                        hintText: 'www.businessurl.com'),
                  ],
                ),
                getHeightSizedBox(h: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    getButtons(text: 'ok'.tr, onTap: onOk),
                    getHeightSizedBox(w: 30),
                    getButtons(text: 'cancel'.tr, onTap: onCancel),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
