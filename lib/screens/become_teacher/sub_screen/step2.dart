import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/screens/become_teacher/become_tutor_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/button.dart';
import '../widgets/title_line.dart';

class VideoStep extends StatefulWidget {
  @override
  State<VideoStep> createState() => _VideoStepState();
}

class _VideoStepState extends State<VideoStep> {
  final ImagePicker _picker = ImagePicker();

  BecomeTutorController get controller =>
      Get.find(tag: 'become_tutor_controller');
  VideoPlayerController? _videoController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const TitleLine(title: "Introduction video"),
        const SizedBox(height: 10),
        instructions(),
        const SizedBox(height: 10),
        Align(
          alignment: AlignmentDirectional.center,
          child: ElevatedButton(
            onPressed: uploadVideo,
            child: const Text("Choose video"),
          ),
        ),
        videoPlayer(),
      ],
    );
  }

  Container instructions() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.blue[50], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("A few helpful tips:"),
          Text("1. Find a clean and quiet space"),
          Text("2. Smile and look at the camera"),
          Text("3. Dress smart"),
          Text("4. Speak for 1-3 minutes"),
          Text("5. Brand yourself and have fun!"),
        ],
      ),
    );
  }

  Widget videoPlayer() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        _videoController == null
            ? SizedBox.shrink()
            : SizedBox(
                height: Get.height / 2,
                width: Get.width,
                child: VideoPlayer(_videoController!),
              )
      ],
    );
  }

  void uploadVideo() async {
    await cleanUp();
    var source = ImageSource.gallery;
    final video = await _picker.pickVideo(source: source);
    if (video == null) return;
    setState(() {
      _videoController = VideoPlayerController.contentUri(Uri.file(video.path));
    });
    _videoController?.addListener(() {
      setState(() {});
    });
    controller.video = video.path;
    await _videoController?.setLooping(true);
    _videoController?.initialize().then((value) => setState(() {}));
    _videoController?.play();
  }

  Future cleanUp() async {
    await _videoController?.pause();
    await _videoController?.dispose();
    _videoController = null;
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}
