import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/categoriescontroller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';

class ViewAll extends StatelessWidget {
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('business_categories'.tr),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder(
              builder: (CategoriesController controller) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        title: Text('Hello'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        trailing: GestureDetector(
                            onTap: () {},
                            child: buildWidget(AppImages.checked, 21, 21)),
                      ),
                      Divider(
                        height: 0,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: CustomButton(
              type: CustomButtonType.colourButton,
              text: 'apply'.tr,
              onTap: () {
                Get.back();
              },
              padding: 30,
            ),
          ),
          getHeightSizedBox(h: 20)
        ],
      ),
    );
  }
}
