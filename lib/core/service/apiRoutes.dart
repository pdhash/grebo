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
}
