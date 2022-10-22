
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class VideoCallScreen extends StatelessWidget {

  VideoCallScreen({Key? key}) : super(key: key);

  int endTime =DateTime.now().add(Duration(seconds: 20)).millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Meeting Room",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 15),
                            Text(
                              "24:00",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          "You are the only one in the meeting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 230,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Lesson will be started after",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          CountdownTimer(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            endWidget: Text('Times up', style: TextStyle(color: Colors.white),),
                            endTime: endTime,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.grey[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.mic_none,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.videocam_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 28,
                    color: Colors.white,
                  ),
                  const Icon(
                    Icons.switch_camera,
                    size: 28,
                    color: Colors.white,
                  ),
                  const Icon(
                    Icons.more_vert,
                    size: 28,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {Navigator.pop(context);},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(
                        Icons.call_end,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}