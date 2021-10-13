import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/serviceOfferedController.dart';
import 'package:grebo/ui/screens/editBusinessprofile/details3.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:pagination_view/pagination_view.dart';

import 'home.dart';

class ServiceOffered extends StatelessWidget {
  final bool isEdit;
  final ServiceOfferedController serviceOfferedController =
      Get.put(ServiceOfferedController());
  ServiceOffered({Key? key, this.isEdit = false}) : super(key: key);

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
      // body: ListView.builder(
      //   itemCount: 7,
      //   itemBuilder: (context, index) {
      //     return buildListTile(
      //         image: AppImages.serviceOffered, text: 'Volunteer Care');
      //   },
      // ),
      body: PaginationView(
        itemBuilder:
            (BuildContext context, ServiceList serviceList, int index) {
          return buildListTile(
              text: serviceList.name, image: serviceList.image);
        },
        pullToRefresh: true,
        pageFetch: serviceOfferedController.getServices,
        onEmpty: Center(
          child: Text('no_post_found'.tr),
        ),
        onError: (error) {
          return Center(child: Text(error));
        },
      ),
    );
  }

  Widget buildListTile({required String text, required String image}) {
    print(image);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: AssetImage(AppImages.placeHolder),
                  image: NetworkImage("${imageUrl + image}"),
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              )
              // Container(
              //   height: 60,
              //   width: 60,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage(image), fit: BoxFit.fill)),
              // ),
              ,
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
