import 'dart:convert';
import 'dart:io';

import 'package:grebo/core/service/apiHandler.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/model/commentModel.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';
import 'package:grebo/ui/screens/homeTab/model/reviewModel.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

class PostRepo {
  static Future<PostModel?> fetchProviderPost(int page) async {
    var response = await API.apiHandler(
        url: APIRoutes.providerPostList,
        showLoader: false,
        header: {"Authorization": userController.userToken},
        body: jsonEncode({"page": page}));
    if (response != null) {
      print("fetchProviderPost $response");
      return PostModel.fromJson(response);
    } else
      return null;
  }

  static Future<PostModel?> fetchUserPost(
      {required int page,
      required double longitude,
      required double latitude,
      List<String>? categoryRefs}) async {
    var response = await API.apiHandler(
      url: APIRoutes.userPostList,
      showLoader: false,
      header: {
        "Authorization": userController.userToken,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "page": page,
          "longitude": longitude,
          "latitude": latitude,
          "categoryRefs": categoryRefs
        },
      ),
    );
    if (response != null) {
      {
        print("fetchUserPost $response");
        return PostModel.fromJson(response);
      }
    } else
      return null;
  }

  static Future postUpload(File image, Map<String, dynamic> caption,
      bool isImage, File? thumbnail) async {
    String map = jsonEncode(caption);
    var response = await API.multiPartAPIHandler(
        url: APIRoutes.addPost,
        thumbnail: thumbnail,
        multiPartImageKeyName: isImage ? "image" : "video",
        fileImage: [image],
        field: {"data": map},
        header: {"Authorization": userController.userToken});
    if (response != null) {
      return response;
    } else
      return null;
  }

  static Future likeUpdate(String id, bool isLike) async {
    var response = await API.apiHandler(
        url: APIRoutes.updateLike,
        showLoader: false,
        body: jsonEncode({"postRef": id, "isLike": isLike}),
        header: {
          "Authorization": userController.userToken,
          "Content-Type": 'application/json',
        });
    if (response != null) {
      return response;
    } else
      return null;
  }

  static Future<CommentModel?> fetchComments(
      {required String postRef, required int page}) async {
    var response = await API.apiHandler(
      url: APIRoutes.getComments,
      showLoader: false,
      header: {
        "Authorization": userController.userToken,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {"postRef": postRef, "page": page},
      ),
    );
    if (response != null) {
      return CommentModel.fromJson(response);
    } else
      return null;
  }

  static Future addComments(
      {required String postRef, required String commentsText}) async {
    var response = await API.apiHandler(
      url: APIRoutes.addComments,
      showLoader: false,
      header: {
        "Authorization": userController.userToken,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {"postRef": postRef, "text": commentsText},
      ),
    );
    if (response != null) {
      return response;
    } else
      return null;
  }

  static Future<ReviewModel?> fetchReview(int page, String businessRef) async {
    var response = await API.apiHandler(
        url: APIRoutes.review,
        showLoader: false,
        header: {
          "Authorization": userController.userToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"businessRef": businessRef}));
    if (response != null) {
      return ReviewModel.fromJson(response);
    } else
      return null;
  }

  static Future updateReview(Map<String, dynamic> review, File? image) async {
    String map = jsonEncode(review);
    var response;
    if (image == null) {
      response = await API.multiPartAPIHandler(
          url: APIRoutes.reviewUpdate,
          header: {"Authorization": userController.userToken},
          field: {"data": map});
    } else
      response = await API.multiPartAPIHandler(
          url: APIRoutes.review,
          header: {"Authorization": userController.userToken},
          field: {"data": map},
          fileImage: [image]);
    if (response != null) {
      return response;
    } else
      return null;
  }

  static Future<UserModel?> fetchUserDetail(String businessRef) async {
    var response = await API.apiHandler(
        url: APIRoutes.userDetail,
        showLoader: false,
        header: {"Authorization": userController.userToken},
        body: jsonEncode({"businessRef": businessRef}));
    if (response != null) {
      return UserModel.fromJson(response["data"]);
    } else
      return null;
  }

  static Future followProvider(String businessRef, bool follow) async {
    var response = await API.apiHandler(
        url: APIRoutes.follow,
        showLoader: false,
        header: {
          "Authorization": userController.userToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"businessRef": businessRef, "isFollow": follow}));
    if (response != null) {
      return response;
    } else
      return null;
  }
}
