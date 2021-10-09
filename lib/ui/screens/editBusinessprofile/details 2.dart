import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/availabilitycontroller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';

import 'details1.dart';
import 'details3.dart';

class DetailsPage2 extends StatelessWidget {
  final bool showEdit;
  final AvailabilityController availabilityController =
      Get.put(AvailabilityController());

  DetailsPage2({Key? key, this.showEdit = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AvailabilityController controller) {
        return Scaffold(
          appBar: appBar(
            'set_availability'.tr,
            [
              showEdit
                  ? Padding(
                      padding: const EdgeInsets.only(top: 22, right: 25),
                      child: Text(
                        '2 of 3',
                        style: TextStyle(
                            color: AppColor.kDefaultFontColor.withOpacity(0.72),
                            fontSize: 15),
                      ),
                    )
                  : SizedBox()
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
                      itemCount: weekDayList.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 4,
                          mainAxisSpacing: 16),
                      itemBuilder: (context, index) => Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (controller.daysCount.contains(index)) {
                                      controller.removeDays(index);
                                    }
                                    controller.addDays(index);
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration:
                                        controller.daysCount.contains(index)
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
                                  weekDayList[index],
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
                  children: [
                    timeBox(
                      text: 'opening_hour'.tr,
                      context: context,
                      onTap: () {
                        if (PlatformCheck.isIOS) {
                          DatePicker.showTime12hPicker(
                            context,
                            showTitleActions: true,
                            onChanged: (date) {},
                            onConfirm: (date) {
                              controller.defaultTime = dateFormat.format(date);
                            },
                          );
                        } else {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, widget) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: false),
                                child: widget as Widget,
                              );
                            },
                          )..then((value) {
                              final localizations =
                                  MaterialLocalizations.of(context);
                              final formattedTimeOfDay =
                                  localizations.formatTimeOfDay(value!);
                              controller.defaultTime = formattedTimeOfDay;
                            });
                        }
                      },
                      timeText: controller.defaultTime,
                    ),
                    getHeightSizedBox(w: 45),
                    timeBox(
                      text: 'closing_hour'.tr,
                      context: context,
                      onTap: () {
                        if (PlatformCheck.isIOS) {
                          DatePicker.showTime12hPicker(
                            context,
                            showTitleActions: true,
                            onChanged: (date) {},
                            onConfirm: (date) {
                              controller.defaultTime = dateFormat.format(date);
                            },
                          );
                        } else {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, widget) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: false),
                                child: widget as Widget,
                              );
                            },
                          )..then((value) {
                              final localizations =
                                  MaterialLocalizations.of(context);
                              final formattedTimeOfDay =
                                  localizations.formatTimeOfDay(value!);
                              controller.defaultTimeEnd = formattedTimeOfDay;
                            });
                        }
                      },
                      timeText: controller.defaultTimeEnd,
                    )
                  ],
                ),
                Spacer(),
                SafeArea(
                    child: CustomButton(
                  text: 'next'.tr,
                  onTap: () {
                    Get.to(() => DetailsPage3());
                  },
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
    required Function()? onTap,
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
          onTap: onTap,
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
