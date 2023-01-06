import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class IntroVideo extends StatefulWidget {
  final String link;

  const IntroVideo({super.key, required this.link});

  @override
  State<IntroVideo> createState() => _IntroVideoState();
}

class _IntroVideoState extends State<IntroVideo> {
  VideoPlayerController? _videoController;
  ChewieController? _controller;

  @override
  void initState() {
    _controller = ChewieController(
      videoPlayerController: VideoPlayerController.network(widget.link),
      autoPlay: true,
      looping: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: Get.height * 0.4,
          width: Get.width,
          child: Stack(
            children: [
              Column(children: [
                Expanded(
                  child: Container(
                    color: Get.isDarkMode ? Colors.white12 : Colors.blue,
                  ),
                )
              ]),
              if (_controller != null)
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Chewie(
                    controller: _controller!,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  Future cleanUp() async {
    await _videoController?.pause();
    await _videoController?.dispose();
    await _controller?.pause();
    _controller?.dispose();
  }

  @override
  void dispose() {
    cleanUp();
    super.dispose();
  }
}
