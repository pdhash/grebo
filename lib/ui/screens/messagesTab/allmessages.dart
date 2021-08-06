import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/screens/messagesTab/chatscreen.dart';
import 'package:greboo/ui/shared/postview.dart';

class AllMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              horizontalTitleGap: 10,
              contentPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              leading: buildCircleProfile(
                  image: AppImages.defaultProfile, width: 40, height: 40),
              subtitle: Text(
                'Hi, Is that Arjun! How are you.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    color: AppColor.kDefaultFontColor),
              ),
              title: Text(
                'Samira Sehgal',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(15)),
              ),
              onTap: () {
                Get.to(() => ChatView(index: index));
              },
              trailing: Padding(
                padding: EdgeInsets.only(bottom: 11),
                child: Text(
                  '2:30 PM',
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                      color: AppColor.kDefaultFontColor.withOpacity(0.50)),
                ),
              ),
            ),
            //  getHeightSizedBox(h: 10),
            Divider(
              height: 0,
              thickness: 1,
              color: AppColor.kDefaultFontColor.withOpacity(0.08),
            ),
          ],
        ),
      ),
    );
  }
}
