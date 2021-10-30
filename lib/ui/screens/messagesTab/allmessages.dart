import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/dateTimeFormatExtension.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/messagesTab/chatscreen.dart';
import 'package:grebo/ui/screens/messagesTab/controller/allChatController.dart';
import 'package:grebo/ui/screens/messagesTab/model/chatListModel.dart';
import 'package:pagination_view/pagination_view.dart';

class AllMessages extends StatefulWidget {
  @override
  State<AllMessages> createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (AllChatController controller) {
      return PaginationView(
        pullToRefresh: true,
        // key: UniqueKey(),
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder:
            (BuildContext context, AllChatData allChatData, int index) =>
                chatListTile(allChatData),
        pageFetch: controller.fetchAllChatList,
        onError: (error) {
          return Center(child: Text(error));
        },
        onEmpty: Center(
          child: Text("no_post_found".tr),
        ),
        initialLoader: GetPlatform.isAndroid
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
              ))
            : Center(child: CupertinoActivityIndicator()),
      );
    });
  }

  chatListTile(AllChatData allChatData) {
    return GetBuilder(
      builder: (AllChatController controller) => Column(
        children: [
          ListTile(
            horizontalTitleGap: 12,
            contentPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            leading: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                    placeholder: AssetImage(AppImages.placeHolder),
                    image: NetworkImage(
                        "${imageUrl + allChatData.chatUserDetail.picture}"),
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
                  child: allChatData.unreadCount == 0
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
            subtitle: Text(
              allChatData.lastMessage.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.w400,
                  color: AppColor.kDefaultFontColor),
            ),
            title: Text(
              allChatData.chatUserDetail.name,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenWidth(15)),
            ),
            onTap: () {
              Get.to(() => ChatView(
                  businessRef: allChatData.chatUserDetail.id,
                  userName: allChatData.chatUserDetail.name));
              controller.realAllMessagesLocally(allChatData);
            },
            trailing: Padding(
              padding: EdgeInsets.only(bottom: 11),
              child: Text(
                DateTimeFormatExtension.displayMSGTimeFromTimestamp(
                    allChatData.lastMessage.createdAt.toLocal()),
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    color: AppColor.kDefaultFontColor.withOpacity(0.50)),
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: AppColor.kDefaultFontColor.withOpacity(0.08),
          ),
        ],
      ),
    );
  }
}
