import 'package:get/get.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/baseScreen/controller/baseController.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';

import '../home.dart';

class HomeController extends GetxController {
  int page = 1;

  HomeController() {
    page = 1;
  }
  RxBool descTextShowFlag = false.obs;

  List<String> selectedCategory = [];

  updateCategory(String id) {
    if (selectedCategory.contains(id)) {
      selectedCategory.remove(id);
    } else {
      selectedCategory.add(id);
    }
    update();
    Home.paginationViewKey.currentState!.refresh();
  }

  List<PostData> getPosts = [];

//for providers post
  Future<List<PostData>> fetchProviderPost(int offset) async {
    if (offset == 0) {
      page = 1;
      getPosts.clear();
    }
    if (page == -1) return [];

    var request = await PostRepo.fetchProviderPost(page);
    getPosts = request!.postData;
    page = request.hasMore ? page + 1 : -1;

    return getPosts;
  }

  //for user posts

  Future<List<PostData>> fetchUserPost(int offset) async {
    if (userController.globalCategory.length == 0) {
      userController.globalCategory = await EditProfileRepo.getCategories();
    }
    double lat = Get.find<BaseController>().latitude;
    double lang = Get.find<BaseController>().longitude;
    if (lat == 0 && lang == 0) return [];
    if (offset == 0) page = 1;
    if (page == -1) return [];

    var request = await PostRepo.fetchUserPost(
        page: page,
        latitude: lat,
        longitude: lang,
        categoryRefs: selectedCategory);
    getPosts = request!.postData;
    page = request.hasMore ? page + 1 : -1;
    return getPosts;
  }

  Future likeUpdate(PostData postData) async {
    int? index = getPosts.indexWhere((element) => element.id == postData.id);

    if (index != -1) {
      getPosts[index].isLike = !getPosts[index].isLike;
      if (getPosts[index].isLike) {
        getPosts[index].like += 1;
      } else {
        getPosts[index].like -= 1;
      }
    }

    update();
  }

  late String _currentPostRef;

  String get currentPostRef => _currentPostRef;

  set currentPostRef(String value) {
    _currentPostRef = value;
    update();
  }

  addComment(PostData postData, String commentText) async {
    getPosts[getPosts.indexWhere((element) => element.id == currentPostRef)]
        .comment += 1;
    update();

    await PostRepo.addComments(
            postRef: currentPostRef, commentsText: commentText)
        .then((value) => print("============$value"));
  }
}
