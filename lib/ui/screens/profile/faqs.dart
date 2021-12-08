import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/profile/model/faqsModel.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:pagination_view/pagination_view.dart';

import 'controller/faqsController.dart';

class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  final FaqsController faqsController = Get.put(FaqsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'faqs'.tr),
      body: GetBuilder(
        builder: (FaqsController controller) => PaginationView(
          pullToRefresh: true,
          physics: BouncingScrollPhysics(),
          itemBuilder:
              (BuildContext context, ListElement listElement, int index) =>
                  faqsBody(listElement, index),
          pageFetch: faqsController.fetchFaqs,
          onError: (error) {
            print("Error $error");
            return Center(child: Text(error));
          },
          onEmpty: Center(
            child: Text("no_data_found".tr),
          ),
          initialLoader: GetPlatform.isAndroid
              ? Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 2,
                ))
              : Center(child: CupertinoActivityIndicator()),
        ),
      ),
    );
  }

  faqsBody(ListElement listElement, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 18,
            onTap: () {
              listElement.isSelected = !listElement.isSelected;
              faqsController.update();
            },
            title: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                listElement.question,
                style: TextStyle(
                    color: AppColor.kDefaultFontColor,
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.bold),
              ),
            ),
            trailing: listElement.isSelected != true
                ? buildWidget(AppImages.dropdownClose, 8, 15)
                : buildWidget(AppImages.dropdownOpen, 8, 15),
          ),
          Divider(
            color: Color(0xff707070).withOpacity(0.40),
            thickness: 1,
            height: 5,
          ),
          listElement.isSelected != true
              ? SizedBox()
              : Column(
                  children: [
                    getHeightSizedBox(h: 15),
                    Text(
                      listElement.answer,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                          height: 1.3,
                          color: AppColor.kDefaultFontColor.withOpacity(0.82)),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
