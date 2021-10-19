//development
const String url = "http://3.110.6.163:3000/api/";
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
  static const String addServices = url + "services/add";
  static const String updateServices = url + "services/update";
  static const String updateLike = url + "like/update";
  static const String serviceList = url + "services/list";
  static const String categoryList = url + "category/list";
  static const String notificationList = url + "notification/list";
  static const String getComments = url + "comment/list";
  static const String addComments = url + "comment/add";
  static const String socialLogin = url + "user/socialLogin";
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
