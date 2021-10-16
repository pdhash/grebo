import 'package:get/get.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/model/commentModel.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';

import '../../../../main.dart';

class PostDetailController extends GetxController {
  int commentPage = 1;

  PostDetailController() {
    commentPage = 1;
  }
  late String selectedPostRef;

  List<CommentsData> last2Comments = [];

  Future fetchCommentsLast2() async {
    last2Comments.clear();

    var request = await PostRepo.fetchComments(postRef: selectedPostRef);
    request!.data
        .asMap()
        .map((i, value) =>
            i < 2 ? MapEntry(i, last2Comments.add(value)) : MapEntry(i, value))
        .values
        .toList();
    print("last two == ${last2Comments.length}");
    update();
  }

  late String _commentText;

  String get commentText => _commentText;

  set commentText(String value) {
    _commentText = value;
    update();
  }

  Future addComments(PostData postData) async {
    var currentComment = CommentsData(
        name: userController.user.name,
        createdAt: DateTime.now(),
        text: commentText,
        picture: userController.user.picture,
        updatedAt: DateTime.now());
    getComments.add(currentComment);
    last2Comments.removeLast();
    last2Comments.insert(0, currentComment);

    update();
    homeController.addComment(postData, commentText);
    commentText = "";
  }

  List<CommentsData> getComments = [];

  Future<List<CommentsData>> fetchComments(int offset) async {
    // print("POstRef from global === $currentPostRef}");
    if (offset == 0) commentPage = 1;
    if (commentPage == -1) return [];
    var request = await PostRepo.fetchComments(postRef: selectedPostRef);
    getComments.clear();
    getComments = request!.data;
    commentPage = request.hasMore ? commentPage + 1 : -1;
    return getComments;
  }

  late HomeController homeController;
  @override
  void onInit() {
    homeController = Get.find<HomeController>();
    selectedPostRef = homeController.currentPostRef;
    fetchCommentsLast2();
    super.onInit();
  }
}
