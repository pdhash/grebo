import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/dateTimeFormatExtension.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/businessprofile.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/postdetails.dart';
import 'package:grebo/ui/screens/notifications/controller/allNotificationController.dart';
import 'package:grebo/ui/screens/notifications/model/notificationModel.dart';
import 'package:pagination_view/pagination_view.dart';

class AllNotification extends StatelessWidget {
  final NotificationController notificationController =
      Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (NotificationController controller) => PaginationView(
          itemBuilder: (BuildContext context, Datum notifyData, int index) {
            return notifyListTile(notifyData: notifyData);
          },
          physics: AlwaysScrollableScrollPhysics(),
          pullToRefresh: true,
          pageFetch: notificationController.fetchNotification,
          onEmpty: Center(
            child: Text('no_post_found'.tr),
          ),
          onError: (error) {
            return Center(child: Text(error));
          },
          initialLoader: GetPlatform.isAndroid
              ? Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 2,
                ))
              : Center(child: CupertinoActivityIndicator())),
    );
  }

  notifyListTile({required Datum notifyData}) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 12,
          minVerticalPadding: 17,
          onTap: () {
            print(notifyData.seen);
            if (notifyData.seen == false) {
              notificationController.readNotification(
                  notifyData.id, notifyData);
            }
            if (notifyData.type == 3) {
              Get.to(() => BusinessProfile(
                    businessRef: notifyData.sourceRef,
                    isShow: false,
                  ));
            } else if (notifyData.type == 4) {
              Get.find<HomeController>().currentPostRef = notifyData.sourceRef;
              Get.to(() => PostDetails(
                    postRef: notifyData.sourceRef,
                  ));
            }
          },
          contentPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage(
                  placeholder: AssetImage(AppImages.placeHolder),
                  image: NetworkImage(imageUrl + notifyData.image),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.placeHolder,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    );
                  },
                  height: 40,
                  width: 40,
                ),
              ),
              Positioned(
                bottom: 0,
                right: -3,
                child: notifyData.seen
                    ? SizedBox()
                    : CircleAvatar(
                        radius: getProportionateScreenWidth(8),
                        backgroundColor: Colors.white,
                        child: Center(
                          child: CircleAvatar(
                            radius: getProportionateScreenWidth(6.5),
                            backgroundColor: Color(0xff8BC53F),
                          ),
                        ),
                      ),
              )
            ],
          ),
          title: Text(
            notifyData.text,
            maxLines: 2,
            style: TextStyle(fontSize: getProportionateScreenWidth(15)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateTimeFormatExtension.displayChatTimeFromTimestamp(
                    notifyData.createdAt.toLocal()),
                style: TextStyle(
                    color: AppColor.kDefaultFontColor.withOpacity(0.65),
                    fontSize: getProportionateScreenWidth(12)),
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }
}
