import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);

  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    print("Is current user ${isCurrentUser}");
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: isCurrentUser
                ? AlignmentDirectional.centerEnd
                : AlignmentDirectional.centerStart,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? (isCurrentUser ? Colors.blueGrey : Colors.white38)
                    : (isCurrentUser ? Colors.blue : Colors.grey[300]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  text,
                  style: Get.isDarkMode
                      ? Get.theme.textTheme.bodyText1!.copyWith(
                          color: isCurrentUser ? Colors.white : Colors.white)
                      : Get.theme.textTheme.bodyText1!.copyWith(
                          color: isCurrentUser ? Colors.white : Colors.black87),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
