import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxBool descTextShowFlag = false.obs;
  final PageController pageController = PageController(initialPage: 0);
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
      'image': null
    },
    {
      'title':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text',
      'image': 'assets/image/static/ic_post_img.png'
    },
    {
      'title': 'Lorem Ipsum is simply dummy text of ',
      'image': 'assets/image/static/ic_post_video_cover_img.png'
    },
    {'title': null, 'image': 'assets/image/static/ic_post_video_cover_img.png'},
  ];
}
