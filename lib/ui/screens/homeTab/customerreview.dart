import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:greboo/ui/shared/postview.dart';

import 'givefeedback.dart';

class CustomerReviewed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('customer_reviews'.tr),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return reviewBox();
            },
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 6,
                      offset: Offset(0, -2),
                      color: AppColor.kDefaultFontColor.withOpacity(0.05))
                ]),
                child: Column(
                  children: [
                    getHeightSizedBox(h: 12),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomButton(
                            type: CustomButtonType.colourButton,
                            text: 'give_feedback'.tr,
                            onTap: () {
                              Get.to(() => GiveFeedback());
                            }),
                      ),
                    ),
                    getHeightSizedBox(h: 12),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget reviewBox() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: AppColor.kDefaultFontColor.withOpacity(0.07),
                blurRadius: 6,
                offset: Offset(0, 1))
          ]),
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding)
          .copyWith(bottom: 10, top: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                buildCircleProfile(
                    image: AppImages.defaultProfile, height: 40, width: 40),
                getHeightSizedBox(w: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sanjay Saini',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(14)),
                    ),
                    getHeightSizedBox(h: 4),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: Color(0xffE8E8E8),
                      itemSize: 16,
                      itemPadding: EdgeInsets.only(right: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(0xffFAAA01),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                )
              ],
            ),
            getHeightSizedBox(h: 10),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
