import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';

class BuildBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeScreenController controller) {
      List<Widget> iconData = [
        buildWidget(
            controller.current == 0 ? AppImages.homeActive : AppImages.home),
        buildWidget(
            controller.current == 1 ? AppImages.chatActive : AppImages.chat),
        buildWidget(controller.current == 2
            ? AppImages.notificationActive
            : AppImages.notification),
        buildWidget(controller.current == 3
            ? AppImages.profileActive
            : AppImages.profile),
      ];
      return BottomAppBar(
        elevation: 0,
        child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: AppColor.kDefaultFontColor.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5))
            ]),
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  4,
                  (index) => GestureDetector(
                      onTap: () {
                        controller.pageController.animateToPage(index,
                            duration: Duration(microseconds: 1),
                            curve: Curves.ease);
                        controller.current = index;
                      },
                      child: iconData[index])),
            )),
      );
    });
  }

  Widget buildWidget(String image) {
    return Container(
      height: getProportionateScreenWidth(20.5),
      width: getProportionateScreenWidth(20.5),
      child: SvgPicture.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}
