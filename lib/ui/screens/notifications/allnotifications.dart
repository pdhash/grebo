import 'package:flutter/material.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/shared/postview.dart';

class AllNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              horizontalTitleGap: 12,
              minVerticalPadding: 17,
              //  tileColor: Colors.blue.shade50,
              contentPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              leading: Stack(
                overflow: Overflow.visible,
                children: [
                  buildCircleProfile(
                      image: AppImages.defaultProfile, width: 40, height: 40),
                  Positioned(
                    bottom: 0,
                    right: -3,
                    child: CircleAvatar(
                      radius: getProportionateScreenWidth(8),
                      backgroundColor: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius: getProportionateScreenWidth(6.5),
                          backgroundColor: Color(0xff8BC53F),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              title: Text(
                'Admin, app as new features. update now to check',
                style: TextStyle(fontSize: getProportionateScreenWidth(15)),
              ),
              subtitle: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Today 2:30 PM',
                  style: TextStyle(
                      color: AppColor.kDefaultFontColor.withOpacity(0.65),
                      fontSize: getProportionateScreenWidth(12)),
                ),
              ),
            ),
            //getHeightSizedBox(h: 10),
            Divider(
              height: 0,
            )
          ],
        );
      },
    );
  }
}
