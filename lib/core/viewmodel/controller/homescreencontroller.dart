import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/viewmodel/controller/selectservicecontoller.dart';

class HomeScreenController extends GetxController {
  ServiceController serviceController = Get.put(ServiceController());
  RxBool descTextShowFlag = false.obs;
  final PageController pageController = PageController(initialPage: 0);
  int _pageChanged = 0;

  int get pageChanged => _pageChanged;

  set pageChanged(int value) {
    _pageChanged = value;
    update();
  }

  int _current = 0;

  int get current => _current;

  set current(int value) {
    _current = value;
    update();
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
}
