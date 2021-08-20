import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/alertdialogue.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';

enum DescriptionScreen { aboutUs, termsAndConditions }

class AboutUsAndTAndC extends StatelessWidget {
  final DescriptionScreen screenType;

  const AboutUsAndTAndC({Key? key, required this.screenType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(DescriptionScreen.aboutUs == screenType
          ? 'about_us'.tr
          : 'terms_and_conditions'.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
            .copyWith(top: 5),
        child: Text(
          DescriptionScreen.aboutUs == screenType
              ? 'aboutusdes'.tr
              : 'termsandconditiondes'.tr,
          style: TextStyle(
              height: 1.3,
              color: AppColor.kDefaultFontColor.withOpacity(0.81),
              fontSize: getProportionateScreenWidth(15)),
        ),
      ),
    );
  }
}

class ContactAdmin extends StatelessWidget {
  const ContactAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('contact_admin'.tr),
      body: SingleChildScrollView(
          child: Column(
        children: [
          getHeightSizedBox(h: 10),
          Container(
            height: 187,
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffC4C4C4))),
            child: TextField(
              textInputAction: TextInputAction.go,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  hintText: 'how_can_we_help'.tr,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: AppColor.kDefaultFontColor,
                      fontSize: getProportionateScreenWidth(16))),
            ),
          ),
          getHeightSizedBox(h: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomButton(
                type: CustomButtonType.colourButton,
                text: 'save'.tr,
                onTap: () {
                  disposeKeyboard();
                  showCustomDialog(
                      context: context,
                      height: 150,
                      content: 'dialog_msg'.tr,
                      contentSize: 15,
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      color: AppColor.kDefaultColor,
                      okText: 'ok'.tr);
                }),
          )
        ],
      )),
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
// body: ListView.builder(
// itemCount: 2,
// itemBuilder: (context, index) => Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: kDefaultPadding),
// child: ExpansionTile(
// tilePadding: EdgeInsets.zero, maintainState: true,
// collapsedBackgroundColor: Colors.transparent,
// backgroundColor: Colors.transparent,
// title: Text(
// 'Question $index',
// style: TextStyle(
// color: AppColor.kDefaultFontColor,
// fontSize: getProportionateScreenWidth(16),
// fontWeight: FontWeight.bold),
// ),
// // collapsedIconColor: AppColor.kDefaultFontColor,
// collapsedTextColor: AppColor.kDefaultFontColor,
// children: [
// Divider(),
// Text(
// "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
// style: TextStyle(
// fontSize: getProportionateScreenWidth(14)),
// )
// ],
// trailing: buildWidget(AppImages.dropdownClose, 8, 15),
// ),
// )));
