import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/service/googleAdd/addServices.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/businesscontroller.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/editBusinessprofile/details1.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/homeTab/serviceoffered.dart';
import 'package:grebo/ui/screens/messagesTab/chatscreen.dart';
import 'package:grebo/ui/shared/alertdialogue.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/userController.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customerreview.dart';

class BusinessProfile extends StatefulWidget {
  final isShow;

  final String businessRef;

  BusinessProfile({
    Key? key,
    this.isShow = false,
    required this.businessRef,
  }) : super(key: key);

  @override
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final BusinessController businessController = Get.put(BusinessController());

  @override
  void initState() {
    GoogleAddService.createInterstitialAd();
    GoogleAddService.showInterstitialAd();
    if (userController.user.userType ==
        getServiceTypeCode(ServicesType.userType)) {
      businessController.fetchUserDetail(widget.businessRef);
    } else
      businessController.userModel = userController.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPro(),
      body: GetBuilder(
        builder: (BusinessController controller) {
          return controller.userModel.id == ""
              ? Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(
                          strokeWidth: 2,
                        ))
              : GetBuilder(
                  builder: (UserController con) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          imageView(),
                          getHeightSizedBox(h: 15),
                          businessNameIntro(),
                          getHeightSizedBox(h: 15),
                          userController.user.userType ==
                                  getServiceTypeCode(ServicesType.userType)
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        contactButton(
                                            image: AppImages.follow,
                                            title: controller.userModel.isFollow
                                                ? "Unfollow".tr
                                                : 'follow'.tr,
                                            onTap: () {
                                              if (controller.userModel.isFollow)
                                                controller.follow(false);
                                              else
                                                controller.follow(true);
                                            }),
                                        contactButton(
                                            image: AppImages.call,
                                            title: 'contact'.tr,
                                            onTap: () async {
                                              if (await canLaunch(
                                                  'tel:${controller.userModel.phoneNumber}')) {
                                                await launch(
                                                    'tel:${controller.userModel.phoneNumber}');
                                              } else {
                                                throw 'Could not launch ${controller.userModel.phoneNumber}';
                                              }
                                            }),
                                        contactButton(
                                            image: AppImages.chatNew,
                                            onTap: () {
                                              Get.to(() => ChatView(
                                                    businessRef:
                                                        controller.userModel.id,
                                                    userName: controller
                                                        .userModel.name,
                                                  ));
                                            },
                                            title: 'message'.tr),
                                      ],
                                    ),
                                    getHeightSizedBox(h: 15),
                                    Divider(
                                      height: 0,
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'basic_information'.tr,
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    15)),
                                      ),
                                      getHeightSizedBox(h: 18),
                                      Row(
                                        children: [
                                          buildWidget(
                                              AppImages.callProfile, 41, 41),
                                          getHeightSizedBox(w: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              getHeightSizedBox(h: 3),
                                              Text(
                                                'phone'.tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            16)),
                                              ),
                                              getHeightSizedBox(h: 3),
                                              Text(
                                                "+${businessController.userModel.phoneCode}${businessController.userModel.phoneNumber}",
                                                style: TextStyle(
                                                    color: Color(0xff6E6E6E)
                                                        .withOpacity(0.85),
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15)),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                          getHeightSizedBox(h: 18),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                header('description'.tr),
                                getHeightSizedBox(h: 11),
                                Text(
                                  businessController.userModel.description,
                                  style: TextStyle(
                                      height: 1.5,
                                      color: AppColor.kDefaultFontColor
                                          .withOpacity(0.89),
                                      fontSize:
                                          getProportionateScreenWidth(14)),
                                ),
                                getHeightSizedBox(h: 18),
                                header('website_links'.tr),
                                getHeightSizedBox(h: 16),
                                ...List.generate(
                                    businessController
                                        .userModel.websites.length,
                                    (index) => Column(
                                          children: [
                                            buildLink(businessController
                                                .userModel.websites[index]),
                                            getHeightSizedBox(h: 18),
                                          ],
                                        )),
                              ],
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                          getHeightSizedBox(h: 18),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                header('location'.tr),
                                getHeightSizedBox(h: 11),
                                GetBuilder(
                                    builder: (UserController controller) {
                                  return CustomGoogleMap(
                                      latitude: businessController
                                          .userModel.location.coordinates[1],
                                      longitude: businessController
                                          .userModel.location.coordinates[0]);
                                }),
                              ],
                            ),
                          ),
                          getHeightSizedBox(h: 15),
                          userController.user.userType ==
                                  getServiceTypeCode(ServicesType.providerType)
                              ? Column(
                                  children: [
                                    buildTile('customer_reviews'.tr, () {
                                      print(
                                          businessController.userModel.rating);

                                      Get.to(() => CustomerReviewed(
                                            businessRef:
                                                widget.businessRef.toString(),
                                          ));
                                    },
                                        AppImages.customerReview,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            getHeightSizedBox(w: 5),
                                            Icon(
                                              Icons.star,
                                              color: Color(0xffFFAB00),
                                            ),
                                            getHeightSizedBox(w: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                businessController
                                                    .userModel.rating
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15)),
                                              ),
                                            )
                                          ],
                                        )),
                                    getHeightSizedBox(h: 20),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Divider(
                                      height: 0,
                                    ),
                                    getHeightSizedBox(h: 18),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          header('availability'.tr),
                                          getHeightSizedBox(h: 11),
                                          Text(
                                            'working_days'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Opensans',
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        15)),
                                          ),
                                          getHeightSizedBox(h: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buildWidget(
                                                  AppImages.calender, 23, 26),
                                              getHeightSizedBox(w: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                        text: TextSpan(
                                                            text:
                                                                "${'open'.tr} : ",
                                                            children: [
                                                              TextSpan(
                                                                  text: businessController
                                                                      .getAvailabilityDay
                                                                      .join(
                                                                          ", "),
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .kDefaultFontColor,
                                                                      fontFamily:
                                                                          'Nexa',
                                                                      fontSize:
                                                                          getProportionateScreenWidth(
                                                                              14))),
                                                            ],
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff075935),
                                                                fontFamily:
                                                                    'Nexa',
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        14)))),
                                                    getHeightSizedBox(h: 8),
                                                    RichText(
                                                        text: TextSpan(
                                                            text:
                                                                "${'closed'.tr} : ",
                                                            children: [
                                                              TextSpan(
                                                                  text: businessController
                                                                      .getCloseDay
                                                                      .join(
                                                                          ", "),
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .kDefaultFontColor,
                                                                      fontFamily:
                                                                          'Nexa',
                                                                      fontSize:
                                                                          getProportionateScreenWidth(
                                                                              14))),
                                                            ],
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xffDB0505),
                                                                fontFamily:
                                                                    'Nexa',
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        14))))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          getHeightSizedBox(h: 13),
                                          Text(
                                            'working_hours'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Opensans',
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        15)),
                                          ),
                                          getHeightSizedBox(h: 10),
                                          Row(
                                            children: [
                                              buildWidget(
                                                  AppImages.clock, 23, 23),
                                              getHeightSizedBox(w: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Text(
                                                  '${businessController.userModel.startTime == "" ? "00:00" : dateFormat.format(DateTime.parse(businessController.userModel.startTime).toLocal())}-${businessController.userModel.endTime == "" ? "00:00" : dateFormat.format(DateTime.parse(businessController.userModel.endTime).toLocal())}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              13)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    getHeightSizedBox(h: 15),
                                    Divider(
                                      height: 0,
                                    ),
                                    buildTile('services_offered'.tr, () {
                                      print(widget.businessRef);
                                      Get.to(() => ServiceOffered(
                                            businessRef: widget.businessRef,
                                          ));
                                    }, AppImages.serviceOffer),
                                    Divider(
                                      height: 0,
                                    ),
                                    buildTile('customer_reviews'.tr, () {
                                      Get.to(() => CustomerReviewed(
                                            businessRef:
                                                widget.businessRef.toString(),
                                          ));
                                    }, AppImages.customerReview),
                                    getHeightSizedBox(h: 20)
                                  ],
                                ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  businessNameIntro() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: Color(0xffF4F4F4).withOpacity(0.55),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 19),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            businessController.userModel.businessName,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        getHeightSizedBox(w: 5),
                        GestureDetector(
                            onTap: () {
                              if (businessController.userModel.verifiedByAdmin)
                                return;
                              showCustomDialog(
                                  context: Get.context as BuildContext,
                                  color: AppColor.kDefaultColor,
                                  okText: 'ok'.tr,
                                  onTap: () {
                                    Get.back();
                                  },
                                  title: 'warning'.tr,
                                  content:
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
                                  height: getProportionateScreenWidth(260),
                                  contentSize: 14);
                            },
                            child: buildWidget(
                                businessController.userModel.verifiedByAdmin
                                    ? AppImages.verified
                                    : AppImages.warning,
                                23,
                                24))
                      ],
                    ),
                    getHeightSizedBox(h: 7),
                    Text(
                      businessController.userModel.categories
                          .map((e) => e.name)
                          .toString()
                          .replaceAll("(", "")
                          .replaceAll(")", ""),
                      style: TextStyle(fontSize: 15),
                    ),
                    getHeightSizedBox(h: 7),
                    Text(
                      '${"managed_by".tr} : ${businessController.userModel.name}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              businessController.userModel.verifiedByAdmin
                  ? SizedBox()
                  : Container(
                      height: 36,
                      width: getProportionateScreenWidth(99),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff009345)),
                      child: Center(
                        child: Text(
                          "unverified".tr,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              color: Colors.white),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  imageView() {
    return Container(
      height: 160,
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
              onPageChanged: (val) {
                businessController.currentIndex = val;
              },
              physics: BouncingScrollPhysics(),
              children: businessController.userModel.images
                  .map(
                    (e) => FadeInImage(
                      placeholder: Image.asset(
                        AppImages.placeHolder,
                        fit: BoxFit.cover,
                      ).image,
                      image: NetworkImage("${imageUrl + e}"),
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.placeHolder,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  )
                  .toList()),
          Positioned(bottom: 10, child: buildPagination())
        ],
      ),
    );
  }

  buildPagination() {
    return GetBuilder(
      builder: (BusinessController controller) {
        print(controller.userModel.images.length);
        return businessController.userModel.images.length < 2
            ? SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    businessController.userModel.images.length,
                    (index) => AnimatedContainer(
                          duration: kOnBoardingPageAnimationDuration,
                          margin: EdgeInsets.symmetric(horizontal: 2),
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
      },
    );
  }

  header(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: getProportionateScreenWidth(16)),
    );
  }

  buildLink(String link) {
    return Row(
      children: [
        buildWidget(AppImages.link, 16, 16),
        getHeightSizedBox(w: 15),
        GestureDetector(
          onTap: () async {
            if (await canLaunch('https://$link')) {
              await launch(
                'https://$link',
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

  Widget contactButton(
      {required String image, required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
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
      ),
    );
  }

  appBarPro() {
    return userController.user.userType ==
            getServiceTypeCode(ServicesType.userType)
        ? appBar('business_profile'.tr)
        : appBar('about_business'.tr, [
            widget.isShow
                ? IconButton(
                    padding: EdgeInsets.only(right: 22),
                    onPressed: () {
                      Get.to(() => DetailsPage1(
                            isNext: false,
                          ));
                    },
                    icon: buildWidget(AppImages.editProfile, 19, 19))
                : SizedBox()
          ]);
  }
}

Widget buildImageTile(String image) {
  return Image.asset(image, fit: BoxFit.cover);
}

Widget buildTile(String title, Function()? onTap, String image,
    [Widget? widget]) {
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
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(16)),
                    ),
                  ),
                  widget == null ? SizedBox() : widget
                ],
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

class CustomGoogleMap extends StatefulWidget {
  final double latitude;
  final double longitude;

  CustomGoogleMap({required this.latitude, required this.longitude});

  @override
  CustomGoogleMapState createState() => CustomGoogleMapState();
}

class CustomGoogleMapState extends State<CustomGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 143,
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude), zoom: 13.0),
          onTap: (pos) {
            // print(pos);
            // Marker m = Marker(
            //     markerId: MarkerId('1'), icon: customIcon, position: pos);
            // setState(() {
            //   allMarkers.add(m);
            // });
          },
          key: Key(DateTime.now().toString()),
          markers: Set<Marker>.of({
            Marker(
              // icon: mapPin,
              markerId: MarkerId("center"),
              draggable: false,
              position: LatLng(widget.latitude, widget.longitude),
            )
          }),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
