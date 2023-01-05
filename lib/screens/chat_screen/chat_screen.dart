import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/chat_screen/widgets/tutor_chat.dart';
import 'package:lettutor_app/services/chat_service.dart';
import 'package:lettutor_app/services/user_service.dart';

import 'widgets/chat_input.dart';
import 'widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatService get chatService => Get.find<ChatService>();

  final UserService userService = Get.find<UserService>();

  final messages = [].obs;
  final scrollController = ScrollController();

  String? get userId => userService.userInfo.user?.id;

  @override
  void initState() {
    super.initState();
    chatService.init();
    Future.delayed(Duration(seconds: 2)).then((x) => TutorChat.clickedId.value =
        chatService.chatList.value?.recentList?.first.partner?.id);
    TutorChat.clickedId.listen((id) {
      if (id != null) {
        _openChatForTutor(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black54: Colors.grey[200],
      endDrawer: Drawer(
        child: Obx(
          () => Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                shrinkWrap: true,
                children: tutorChatList(),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView(
        children: [
          listChats(),
          ChatInput(
            onDone: _handleChat,
          ),
        ],
      ),
    );
  }

  Widget listChats() {
    return Obx(
      () {
        Future.delayed(Duration(milliseconds: 500)).then((x) => scrollController
            .animateTo(scrollController.position.maxScrollExtent + 100,
                duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn));
        return SizedBox(
          width: Get.width,
          height: Get.height * 0.8,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: ListView(
                shrinkWrap: true,
                controller: scrollController,
                children: chatService.chats.map((chat) {
                  print('From Id=${chat.fromInfo?.id} userId=$userId');
                  return ChatBubble(
                      text: chat.content ?? "",
                      isCurrentUser: chat.isAuthor(userId));
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> tutorChatList() {
    return (chatService.chatList.value?.recentList ?? []).map((x) {
      return TutorChat(
        partner: x.partner!,
        onClick: () {
          if (TutorChat.clickedId.value == x.partner?.id) {
            TutorChat.clickedId.value = null;
          } else {
            TutorChat.clickedId.value = x.partner?.id;
          }
        },
      );
    }).toList();
  }

  _openChatForTutor(id) async {
    await chatService.loadMessages(id);
  }

  _handleChat(String value) {
    if (TutorChat.clickedId.value == null) {
      return;
    }
    chatService.chat(
      fromId: userId,
      toId: TutorChat.clickedId.value,
      content: value,
    );
  }

  @override
  void dispose() {
    super.dispose();
    chatService.dispose();
  }
}
