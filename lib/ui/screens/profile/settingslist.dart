import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/profile/controller/aboutUsController.dart';
import 'package:grebo/ui/shared/appbar.dart';

enum DescriptionScreen { aboutUs, termsAndConditions }

class AboutUsAndTAndC extends StatefulWidget {
  final DescriptionScreen screenType;

  const AboutUsAndTAndC({Key? key, required this.screenType}) : super(key: key);

  @override
  _AboutUsAndTAndCState createState() => _AboutUsAndTAndCState();
}

class _AboutUsAndTAndCState extends State<AboutUsAndTAndC> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(DescriptionScreen.aboutUs == widget.screenType
          ? 'about_us'.tr
          : 'terms_and_conditions'.tr),
      body: GetBuilder(
        builder: (AboutUsController controller) =>
            controller.aboutUs == null && controller.tc == null
                ? Center(
                    child: GetPlatform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding)
                            .copyWith(top: 5),
                    child: Text(
                      DescriptionScreen.aboutUs == widget.screenType
                          ? aboutUsController.aboutUs.toString()
                          : aboutUsController.tc.toString(),
                      style: TextStyle(
                          height: 1.3,
                          color: AppColor.kDefaultFontColor.withOpacity(0.81),
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                  ),
      ),
    );
  }
}

class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  List<bool> isOpen = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('faqs'.tr),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 18,
                      onTap: () {
                        setState(() {
                          isOpen[index] = !isOpen[index];
                        });
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Question $index',
                          style: TextStyle(
                              color: AppColor.kDefaultFontColor,
                              fontSize: getProportionateScreenWidth(16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: isOpen[index] != true
                          ? buildWidget(AppImages.dropdownClose, 8, 15)
                          : buildWidget(AppImages.dropdownOpen, 8, 15),
                    ),
                    Divider(
                      color: Color(0xff707070).withOpacity(0.40),
                      thickness: 1,
                      height: 5,
                    ),
                    isOpen[index] != true
                        ? SizedBox()
                        : Column(
                            children: [
                              getHeightSizedBox(h: 15),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    height: 1.3,
                                    color: AppColor.kDefaultFontColor
                                        .withOpacity(0.82)),
                              ),
                            ],
                          )
                  ],
                ),
              )),
    );
  }
}
