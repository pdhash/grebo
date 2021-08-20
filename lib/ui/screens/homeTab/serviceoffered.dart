import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/editBusinessprofile/details3.dart';
import 'package:grebo/ui/shared/appbar.dart';

import 'home.dart';

class ServiceOffered extends StatelessWidget {
  final bool isEdit;

  const ServiceOffered({Key? key, this.isEdit = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('services_offered'.tr, [
          isEdit
              ? IconButton(
                  padding: EdgeInsets.only(right: 22),
                  onPressed: () {
                    Get.to(() => DetailsPage3(
                          isShow: false,
                        ));
                  },
                  icon: buildWidget(AppImages.editProfile, 19, 19))
              : SizedBox()
        ]),
        body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return buildListTile(
                image: AppImages.serviceOffered, text: 'Volunteer Care');
          },
        ));
  }

  Widget buildListTile({required String text, required String image}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.fill)),
              ),
              getHeightSizedBox(w: 10),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(14)),
              )
            ],
          ),
        ),
        getHeightSizedBox(h: 15),
        Divider(
          height: 0,
        ),
        getHeightSizedBox(h: 15),
      ],
    );
  }
}
