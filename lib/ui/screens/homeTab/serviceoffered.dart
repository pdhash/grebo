import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/shared/appbar.dart';

class ServiceOffered extends StatelessWidget {
  const ServiceOffered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('services_offered'.tr),
        body: ListView.builder(
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
