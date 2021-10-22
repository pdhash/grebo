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

    var request =
        await PostRepo.fetchComments(postRef: selectedPostRef, page: 1);
    request!.data
        .asMap()
        .map((i, value) =>
            i < 2 ? MapEntry(i, last2Comments.add(value)) : MapEntry(i, value))
        .values
        .toList();
    update();
  }

  late String _commentText;

  String get commentText => _commentText;

  set commentText(String value) {
    _commentText = value;
    update();
  }

  late bool _hasNext;
  bool _isFetching = false;
  bool get hasNext => _hasNext;
  int page = 0;

  List<CommentsData> getComments = [];

  Future addComments(PostData postData) async {
    var currentComment = CommentsData(
        name: userController.user.name,
        createdAt: DateTime.now(),
        text: commentText,
        picture: userController.user.picture,
        updatedAt: DateTime.now());
    getComments.insert(0, currentComment);

    if (last2Comments.length > 1) last2Comments.removeLast();
    last2Comments.insert(0, currentComment);
    update();
    homeController.addComment(postData, commentText);
    commentText = "";
  }

  Future fetchComments() async {
    page = 0;
    _isFetching = false;
    getComments.clear();
    await fetchNextComments();
  }

  Future fetchNextComments() async {
    if (_isFetching) return;
    _isFetching = true;
    page++;
    var request =
        await PostRepo.fetchComments(postRef: selectedPostRef, page: page);
    getComments.addAll(request!.data.map((e) => e));
    _hasNext = request.hasMore;
    _isFetching = false;
    update();
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
