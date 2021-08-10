import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/postdetailbottom.dart';

class ChatView extends StatelessWidget {
  final int index;
  final TextEditingController comment = TextEditingController();

  ChatView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('Samira Sehgal'),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getHeightSizedBox(h: 10),
                      receiveChatBox('Hi!, Samir, How are you'),
                      getHeightSizedBox(h: 10),
                      receiveChatBox('the Last session was great'),
                      getHeightSizedBox(h: 10),
                      Text(' 08:25 Am'),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        getHeightSizedBox(h: 25),
                        sendChatBox(
                          "I' Am Fine, Thanks Margie Friesen",
                        ),
                        getHeightSizedBox(h: 10),
                        Text('08:25 Am '),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SafeArea(
                  child: PostDetailsBottomView(
                    comment: comment,
                    send: () {},
                    hintText: 'textfieldmsg2'.tr,
                  ),
                ))
          ],
        ));
  }
}

Widget receiveChatBox(String title) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Color(0xffF3F3F3)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 15, right: 20, left: 20),
        child: Text(
          title,
          style: TextStyle(fontSize: getProportionateScreenWidth(14)),
        ),
      ),
    ),
  );
}

Widget sendChatBox(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 50),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColor.kDefaultColor),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 15, right: 20, left: 20),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: getProportionateScreenWidth(14)),
        ),
      ),
    ),
  );
}
