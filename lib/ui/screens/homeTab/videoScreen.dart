import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  final String path;

  const VideoScreen({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(path),
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.clear))
        ],
      ),
    ));
  }
}

class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;

  ChewieListItem({
    required this.videoPlayerController,
    Key? key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      showOptions: true,
      // Prepare the video to be played and display the first frame
      autoInitialize: true, showControls: true, autoPlay: true,
      fullScreenByDefault: true,
      looping: false,
      customControls: IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {},
      ),
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
      ],
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    chewieController.dispose();
  }
}
