//development
const String url = "http://3.110.6.163:3000/api/";
const String socketBaseUrl = "http://3.110.6.163:3000";
// const String url = "http://76f5-124-253-245-163.ngrok.io/";
const String imageUrl =
    "https://greboapp.s3.ap-south-1.amazonaws.com/development/images/average/";
const String videoUrl =
    "https://greboapp.s3.ap-south-1.amazonaws.com/development/videos/";

class APIRoutes {
  static const String userLogin = url + "user/login";
  static const String userSignUp = url + "user/signup";
  static const String businessDetail = url + "user/update";
  static const String imageAdd = url + "image/add";
  static const String imageDelete = url + "image/delete";
  static const String userUpdate = url + "user/update";
  static const String emailVerification = url + "user/resendVerification";
  static const String providerPostList = url + "post/myList"; // provider
  static const String userPostList = url + "post/list"; // provider
  static const String addPost = url + "post/add";
  static const String postDetails = url + "post/details";
  static const String addServices = url + "services/add";
  static const String updateServices = url + "services/update";
  static const String updateLike = url + "like/update";
  static const String serviceList = url + "services/list";
  static const String categoryList = url + "category/list";
  static const String notificationList = url + "notification/list";
  static const String notificationSeen = url + "notification/seen";
  static const String getComments = url + "comment/list";
  static const String addComments = url + "comment/add";
  static const String socialLogin = url + "user/socialLogin";
  static const String contactAdmin = url + "user/contactAdmin";
  static const String review = url + "review/list";
  static const String reviewUpdate = url + "review/update";
  static const String userDetail = url + "user/details";
  static const String follow = url + "follow/update";
  static const String appData = url + "appDetail/list";
  static const String faqs = url + "faq/list";
  static const String getChannel = url + "chat/getchannel";
  static const String guestPostList = url + "post/guestList";
  static const String guestPostDetail = url + "post/guestDetails";
  static const String guestCommentList = url + "comment/guestList";
  static const String messageList = url + "chat/listChat";
  static const String getMessages = url + "messages/get";
  static const String countsChats = url + "chat/countChats";
}

enum ContentType { jsonType }

String contentType(ContentType contentType) {
  String type;
  switch (contentType) {
    case ContentType.jsonType:
      type = "application/json";
      break;
  }
  return type;
}
