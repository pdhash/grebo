import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/addservicecontroller.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/ui/screens/editBusinessprofile/details1.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';

class DetailsPage3 extends StatelessWidget {
  final AppImagePicker appImagePicker = AppImagePicker();
  final ImagePickerController imagePickerController =
      Get.find<ImagePickerController>();
  final AddServiceController addServiceController =
      Get.put(AddServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          'add_services_offered'.tr,
          [
            Padding(
              padding: const EdgeInsets.only(top: 22, right: 25),
              child: Text(
                '3 of 3',
                style: TextStyle(
                    color: AppColor.kDefaultFontColor.withOpacity(0.72),
                    fontSize: 15),
              ),
            )
          ],
        ),
        body: GetBuilder(
          builder: (AddServiceController controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: List.generate(controller.defaultField, (index) {
                      controller.textControllers
                          .add(new TextEditingController());
                      return GetBuilder(
                        builder: (ImagePickerController con) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        print('========$index');
                                        appImagePicker.openBottomSheet(
                                            context: context, multiple: false);

                                        controller.addDetails(index);
                                      },
                                      child: controller
                                                  .serviceMultiFile.length >
                                              index
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Container(
                                                height:
                                                    getProportionateScreenWidth(
                                                        66),
                                                width:
                                                    getProportionateScreenWidth(
                                                        66),
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    image: DecorationImage(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0.55),
                                                                BlendMode
                                                                    .dstATop),
                                                        image: FileImage(
                                                          File(controller
                                                              .serviceMultiFile[
                                                                  index]
                                                              .image
                                                              .toString()),
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                            )
                                          : buildWidget(
                                              AppImages.uploadImage2, 66, 66),
                                    ),
                                    getHeightSizedBox(w: 10),
                                    Expanded(
                                        child: TextField(
                                      minLines: 1,
                                      maxLines: 2,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(15),
                                      ),
                                      controller:
                                          controller.textControllers[index],
                                      cursorHeight: 15,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'name_of_service'.tr,
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      15),
                                              color: AppColor.kDefaultFontColor
                                                  .withOpacity(0.49))),
                                    )),
                                    getHeightSizedBox(w: 10),
                                    GestureDetector(
                                      onTap: () {
                                        controller.textControllers[index]
                                            .clear();
                                        controller.defaultField--;
                                      },
                                      child: buildWidget(
                                          AppImages.closeGreen, 24, 24),
                                    ),
                                  ],
                                ),
                              ),
                              getHeightSizedBox(h: 15),
                              Divider(
                                height: 0,
                              ),
                              getHeightSizedBox(h: 23),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () {
                      //  print(controller.defaultField);
                      controller.defaultField++;
                      // print(controller.defaultField);
                    },
                    child: header('add_more_service'.tr),
                  ),
                  CustomButton(
                      type: CustomButtonType.colourButton,
                      text: 'save'.tr,
                      onTap: () {})
                ],
              ),
            );
          },
        ));
  }
}

//
// body: GetBuilder(
//   builder: (AddServiceController controller) {
//     ///---------------------------------------------------extract
//     Widget buildTile(BuildContext context) {
//       if (controller.addServiceBox) {
//         return GetBuilder(
//           builder: (ImagePickerController con) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: kDefaultPadding),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           appImagePicker.openBottomSheet(
//                               context: context, multiple: false);
//                         },
//                         child: con.image == null
//                             ? buildWidget(AppImages.uploadImage2, 66, 66)
//                             : ClipRRect(
//                                 borderRadius: BorderRadius.circular(15),
//                                 child: Container(
//                                   height: getProportionateScreenWidth(66),
//                                   width: getProportionateScreenWidth(66),
//                                   decoration: BoxDecoration(
//                                       color: Colors.black,
//                                       image: DecorationImage(
//                                           colorFilter: ColorFilter.mode(
//                                               Colors.black
//                                                   .withOpacity(0.55),
//                                               BlendMode.dstATop),
//                                           image: FileImage(
//                                             File(con.image.toString()),
//                                           ),
//                                           fit: BoxFit.cover)),
//                                 ),
//                               ),
//                       ),
//                       getHeightSizedBox(w: 10),
//                       Expanded(
//                           child: TextField(
//                         minLines: 1,
//                         maxLines: 2,
//                         style: TextStyle(
//                           fontSize: getProportionateScreenWidth(15),
//                         ),
//                         controller: service,
//                         cursorHeight: 15,
//                         textCapitalization: TextCapitalization.sentences,
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'name_of_service'.tr,
//                             hintStyle: TextStyle(
//                                 fontSize: getProportionateScreenWidth(15),
//                                 color: AppColor.kDefaultFontColor
//                                     .withOpacity(0.49))),
//                       )),
//                       getHeightSizedBox(w: 10),
//                       GestureDetector(
//                         onTap: () {
//                           service.clear();
//                         },
//                         child: buildWidget(AppImages.closeGreen, 24, 24),
//                       ),
//                     ],
//                   ),
//                 ),
//                 getHeightSizedBox(h: 15),
//                 Divider(
//                   height: 0,
//                 ),
//                 getHeightSizedBox(h: 23),
//               ],
//             );
//           },
//         );
//       } else {
//         return SizedBox();
//       }
//     }
//
//     ///-----------------------------------------------------------------------------------------------------
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: List.generate(5, (index) => buildTile(context)),
//           ),
//           //  getHeightSizedBox(h: 15),
//           buildTile(context),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: GestureDetector(
//               onTap: () {
//                 controller.addServiceBox = true;
//               },
//               child: header('add_more_service'.tr),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: CustomButton(
//                 type: CustomButtonType.colourButton,
//                 text: 'save'.tr,
//                 onTap: () {
//                   controller.addServiceBox = false;
//                 }),
//           ),
//           getHeightSizedBox(h: 15)
//         ],
//       ),
//     );
//   },
// ),
