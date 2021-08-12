import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/availabilitycontroller.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';

import 'details1.dart';

class DetailsPage2 extends StatelessWidget {
  final AvailabilityController availabilityController =
      Get.put(AvailabilityController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AvailabilityController controller) {
        return Scaffold(
          appBar: appBar(
            'set_availability'.tr,
            [
              MaterialButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '2 of 3',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.72),
                        fontSize: getProportionateScreenWidth(15)),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeightSizedBox(h: 10),
                header('select_working_days'.tr),
                getHeightSizedBox(h: 16),
                Container(
                  height: 70,
                  child: GridView.builder(
                      itemCount: controller.list.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 4,
                          mainAxisSpacing: 16),
                      itemBuilder: (context, index) => Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    controller.change(index);
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: controller.list[index].selected
                                        ? BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff2C9344))
                                        : BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xff2C9344),
                                                width: 1)),
                                    child: Center(
                                      child: Icon(
                                        Icons.check,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              getHeightSizedBox(w: 5),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  controller.list[index].day,
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(15),
                                      color: AppColor.kDefaultFontColor
                                          .withOpacity(0.80)),
                                ),
                              ),
                            ],
                          )),
                ),
                getHeightSizedBox(h: 20),
                header('select_working_hours'.tr),
                getHeightSizedBox(h: 20),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    timeBox(
                      text: 'opening_hour'.tr,
                      context: context,
                      doneSelectTime: (date) {
                        controller.defaultTime = dateFormat.format(date);
                      },
                      timeText: controller.defaultTime,
                    ),
                    getHeightSizedBox(w: 45),
                    timeBox(
                      text: 'closing_hour'.tr,
                      context: context,
                      doneSelectTime: (date) {
                        controller.defaultTimeEnd = dateFormat.format(date);
                      },
                      timeText: controller.defaultTimeEnd,
                    )
                  ],
                ),
                Spacer(),
                SafeArea(
                    child: CustomButton(
                  text: 'next'.tr,
                  onTap: () {},
                  type: CustomButtonType.colourButton,
                )),
                getHeightSizedBox(h: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget timeBox(
    {required String text,
    required Function(DateTime)? doneSelectTime,
    required BuildContext context,
    required String timeText}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
            color: AppColor.kDefaultFontColor.withOpacity(0.85),
            fontSize: getProportionateScreenWidth(14)),
      ),
      GestureDetector(
          onTap: () {
            if (PlatformCheck.isIOS) {
              DatePicker.showTime12hPicker(context,
                  showTitleActions: true,
                  onChanged: (date) {},
                  onConfirm: doneSelectTime);
            } else {
              showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.dial);
            }
          },
          child: SizedBox(
            width: 110,
            height: 40,
            child: DropdownButtonFormField(
              items: [],
              hint: Text(
                timeText,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: AppColor.kDefaultFontColor),
              ),
              icon: buildWidget(AppImages.dropdownCloseBlack, 7, 15),
            ),
          )),
    ],
  );
}
