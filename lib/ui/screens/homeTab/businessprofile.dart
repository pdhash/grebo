import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/businesscontroller.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/screens/homeTab/serviceoffered.dart';
import 'package:greboo/ui/shared/alertdialogue.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customerreview.dart';

class BusinessProfile extends StatelessWidget {
  final BusinessController businessController = Get.put(BusinessController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('business_profile'.tr),
      body: GetBuilder(
        builder: (BusinessController controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: Get.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView(
                        onPageChanged: (val) {
                          controller.currentIndex = val;
                        },
                        children: [
                          buildImageTile(
                              'assets/image/static/ic_business_profile.png'),
                          buildImageTile(
                              'assets/image/static/ic_business_profile.png'),
                          buildImageTile(
                              'assets/image/static/ic_business_profile.png'),
                        ],
                      ),
                      Positioned(bottom: 10, child: buildPagination())
                    ],
                  ),
                ),
                getHeightSizedBox(h: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Color(0xffF4F4F4).withOpacity(0.55),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  'Business Name',
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              getHeightSizedBox(w: 5),
                              GestureDetector(
                                  onTap: () {
                                    showCustomDialog(
                                        context: context,
                                        color: AppColor.kDefaultColor,
                                        okText: 'ok'.tr,
                                        onTap: () {
                                          Get.back();
                                        },
                                        title: 'warning'.tr,
                                        content: Text(
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      13),
                                              color: AppColor.kDefaultFontColor
                                                  .withOpacity(0.80)),
                                        ),
                                        height:
                                            getProportionateScreenWidth(260));
                                  },
                                  child:
                                      buildWidget(AppImages.verified, 23, 24))
                            ],
                          ),
                          getHeightSizedBox(h: 7),
                          Text(
                            'Health Care',
                            style: TextStyle(fontSize: 15),
                          ),
                          getHeightSizedBox(h: 7),
                          Text(
                            'Managed By: Samira Sehgal',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                getHeightSizedBox(h: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    contactButton(image: AppImages.follow, title: 'follow'.tr),
                    contactButton(
                        image: AppImages.call,
                        title: 'contact'.tr,
                        onTap: () async {
                          if (await canLaunch('tel:8758587289')) {
                            await launch('tel:8758587289');
                          } else {
                            throw 'Could not launch 8758587289';
                          }
                        }),
                    contactButton(
                        image: AppImages.chatNew, title: 'message'.tr),
                  ],
                ),
                getHeightSizedBox(h: 15),
                Divider(
                  height: 0,
                ),
                getHeightSizedBox(h: 18),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header('description'.tr),
                      getHeightSizedBox(h: 11),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s.',
                        style: TextStyle(
                            color: AppColor.kDefaultFontColor.withOpacity(0.89),
                            fontSize: getProportionateScreenWidth(14)),
                      ),
                      getHeightSizedBox(h: 18),
                      header('website_links'.tr),
                      getHeightSizedBox(h: 16),
                      buildLink('www.youtube.com'),
                      getHeightSizedBox(h: 18),
                      buildLink('www.facebook.com'),
                      getHeightSizedBox(h: 18),
                      buildLink('www.instagram.com'),
                      getHeightSizedBox(h: 18),
                      header('location'.tr),
                      getHeightSizedBox(h: 11),
                      Container(
                        height: 143,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      getHeightSizedBox(h: 15),
                      Divider(
                        height: 0,
                      ),
                      getHeightSizedBox(h: 18),
                      header('availability'.tr),
                      getHeightSizedBox(h: 11),
                      Text(
                        'working_days'.tr,
                        style: TextStyle(
                            fontFamily: 'Opensans',
                            fontSize: getProportionateScreenWidth(15)),
                      ),
                      getHeightSizedBox(h: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildWidget(AppImages.calender, 23, 26),
                          getHeightSizedBox(w: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: 'open'.tr,
                                      children: [
                                        TextSpan(
                                            text: ' : Mon,Tue,Wed,Thur,Fri,Sat',
                                            style: TextStyle(
                                                color: AppColor
                                                    .kDefaultFontColor)),
                                      ],
                                      style:
                                          TextStyle(color: Color(0xff075935)))),
                              getHeightSizedBox(h: 10),
                              RichText(
                                  text: TextSpan(
                                      text: 'closed'.tr,
                                      children: [
                                        TextSpan(
                                            text: ' : Sun',
                                            style: TextStyle(
                                                color: AppColor
                                                    .kDefaultFontColor)),
                                      ],
                                      style:
                                          TextStyle(color: Color(0xffDB0505))))
                            ],
                          )
                        ],
                      ),
                      getHeightSizedBox(h: 13),
                      Text(
                        'working_hours'.tr,
                        style: TextStyle(
                            fontFamily: 'Opensans',
                            fontSize: getProportionateScreenWidth(15)),
                      ),
                      getHeightSizedBox(h: 10),
                      Row(
                        children: [
                          buildWidget(AppImages.clock, 23, 23),
                          getHeightSizedBox(w: 10),
                          Text(
                            '9:00 AM-7:00 PM',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(13)),
                          )
                        ],
                      ),
                      getHeightSizedBox(h: 15),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                buildTile('services_offered'.tr, () {
                  Get.to(() => ServiceOffered());
                }, AppImages.serviceOffer),
                Divider(
                  height: 0,
                ),
                buildTile('customer_reviews'.tr, () {
                  Get.to(() => CustomerReviewed());
                }, AppImages.customerReview),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget header(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: getProportionateScreenWidth(16)),
    );
  }

  Widget buildLink(String link) {
    return Row(
      children: [
        buildWidget(AppImages.link, 16, 16),
        getHeightSizedBox(w: 15),
        GestureDetector(
          onTap: () async {
            if (await canLaunch('https://$link')) {
              await launch(
                'https://$link',
                forceSafariVC: true,
                forceWebView: true,
                enableJavaScript: true,
              );
            } else {
              throw 'could not lunch';
            }
          },
          child: Text(
            link,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: AppColor.kDefaultFontColor.withOpacity(0.89)),
          ),
        )
      ],
    );
  }

  Row buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (index) => AnimatedContainer(
                duration: kOnBoardingPageAnimationDuration,
                margin: EdgeInsets.only(right: index == 3 - 1 ? 0 : 5),
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: index == businessController.currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
    );
  }

  Widget contactButton(
      {required String image, required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          buildWidget(image, 17, 18),
          getHeightSizedBox(h: 10),
          Text(
            title,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: AppColor.kDefaultFontColor.withOpacity(0.75)),
          )
        ],
      ),
    );
  }
}

Widget buildImageTile(String image) {
  return Image.asset(image, fit: BoxFit.cover);
}

Widget buildTile(String title, Function()? onTap, String image) {
  return Column(
    children: [
      getHeightSizedBox(h: 15),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Row(
            children: [
              buildWidget(image, 41, 41),
              getHeightSizedBox(w: 10),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(16)),
              ),
              Spacer(),
              buildWidget(AppImages.next, 20, 10),
            ],
          ),
        ),
      ),
      getHeightSizedBox(h: 15),
    ],
  );
}
