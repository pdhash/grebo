import 'package:get/get.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';

class HomeController extends GetxController {
  int page = 1;

  HomeController() {
    page = 1;
  }
  RxBool descTextShowFlag = false.obs;

//for providers post
  Future<List<PostData>> fetchProviderPost(int offset) async {
    if (offset == 0) page = 1;
    if (page == -1) return [];
    List<PostData> getPost = [];
    var request = await PostRepo.fetchProviderPost(page);
    getPost = request!.postData;
    page = request.hasMore ? page + 1 : -1;
    return getPost;
  }

  List<String> selectedCategory = [];
  updateCategory(String id) {
    if (selectedCategory.contains(id)) {
      selectedCategory.remove(id);
    } else
      selectedCategory.add(id);
  }

  //for user posts
  Future<List<PostData>> fetchUserPost(int offset) async {
    if (offset == 0) page = 1;
    if (page == -1) return [];
    List<PostData> getPost = [];
    var request = await PostRepo.fetchUserPost(
        page: page, latitude: 76.779419, longitude: 30.733315);
    getPost = request!.postData;
    page = request.hasMore ? page + 1 : -1;
    return getPost;
  }

  Future likeUpdate(PostData postData) async {
    postData.isLike = !postData.isLike;
    if (postData.isLike) {
      postData.like += 1;
    } else
      postData.like -= 1;

    update();

    PostRepo.likeUpdate(postData.id, postData.isLike);
  }

  late String _currentPostRef;

  String get currentPostRef => _currentPostRef;

  set currentPostRef(String value) {
    _currentPostRef = value;
    update();
  }

  addComment(PostData postData, String commentText) async {
    postData.comment += 1;
    update();
    await PostRepo.addComments(
            postRef: currentPostRef, commentsText: commentText)
        .then((value) => print("============$value"));
  }
}
