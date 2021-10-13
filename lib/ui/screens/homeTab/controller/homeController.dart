import 'package:get/get.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';

class HomeController extends GetxController {
  late bool isNextPost;
  HomeController() {
    isNextPost = true;
  }
  RxBool descTextShowFlag = false.obs;

//for providers post
  Future<List<PostData>> fetchMyPost(int offset) async {
    if (offset == 0) isNextPost = true;
    if (isNextPost == false) return [];
    List<PostData> getPost = [];
    var request = await PostRepo.fetchMyPost();
    getPost = request!.postData;
    isNextPost = request.hasMore;
    return getPost;
  }

  //for user posts
  Future<List<PostData>> fetchAllPost(int offset) async {
    if (offset == 0) isNextPost = true;
    if (isNextPost == false) return [];
    List<PostData> getPost = [];
    var request = await PostRepo.fetchMyPost();
    getPost = request!.postData;
    isNextPost = request.hasMore;
    return getPost;
  }
}

List categories = ['Health care', 'Sports', 'Retailers', 'Transport'];

List<Map<String, dynamic>> list = [
  {
    'title':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is dummy text of the & typesetting industry',
    'image': null,
    'comment': [
      {
        'title':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.',
        'name': 'Sanjay Singh',
        'time': '6hrs',
        'profile': 'assets/image/static/sanjay.png',
      },
      {
        'title':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.',
        'name': 'Sanjay Singh',
        'time': '6hrs',
        'profile': 'assets/image/static/sanjay.png',
      },
      {
        'title':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.',
        'name': 'Sanjay Singh',
        'time': '6hrs',
        'profile': 'assets/image/static/sanjay.png',
      },
      {
        'title':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.',
        'name': 'Sanjay Singh',
        'time': '6hrs',
        'profile': 'assets/image/static/sanjay.png',
      },
      {
        'title':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        'name': 'Swati Singh',
        'time': '7hrs',
        'profile': 'assets/image/static/swati.png',
      }
    ]
  },
  {
    'title':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text',
    'image': 'assets/image/static/ic_post_img.png',
    'comment': null
  },
  {
    'title': 'Lorem Ipsum is simply dummy text of ',
    'image': 'assets/image/static/ic_post_video_cover_img.png',
    'comment': null
  },
  {
    'title': null,
    'image': 'assets/image/static/ic_post_video_cover_img.png',
    'comment': null
  },
];
