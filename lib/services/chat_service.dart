import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:web_socket_channel/io.dart';

import '../models/socket/chat_list.dart';
import '../models/socket/chat_response.dart';
import '../models/tutor_detail/tutor_detail.dart';
import '../utils/mixing.dart';
import 'tutor_service.dart';

class ChatService with AppAPI {
  IOWebSocketChannel? channel;
  final chats = <Chat>[].obs;

  final onlineTutors = <TutorDetail>{}.obs;
  final Rxn<ChatList> chatList = Rxn();
  final tutorService = Get.find<TutorService>();
  final messages = [].obs;
  bool lock = false;

  void init() {
    onlineTutors.clear();
    chatList.value = null;
    messages.clear();

    final userInfo = Get.find<UserService>().userInfo;
    var c = IOWebSocketChannel.connect(Uri.parse(
        'wss://sandbox.api.lettutor.com/socket.io/?EIO=4&transport=websocket'));
    c.stream.listen((data) {
      if (data == "2") {
        c.sink.add("3");
        return;
      }
      final parsedData = _dataParser(data);
      switch (parsedData[0]) {
        case 0:
          try {
            c.sink.add("40");
          } catch (e) {}
          break;
        case 40:
          c.sink.add("42${jsonEncode([
                "connection:login",
                {"user": userInfo.user?.toJson()}
              ])}");
          break;
        case 42:
          final subCommand = parsedData[1][0];
          print(subCommand);
          switch (subCommand) {
            case "chat:joinOrLeave":
              print('Join or leave');
              c.sink.add('42["chat:getRecentList"]');
              break;
            case "chat:returnRecentList":
              _updateChats(parsedData);
              break;
            case "onlineTutors:returnList":
              _updateOnlineTutorsList(parsedData);
              break;
            case "chat:returnNewMessage":
              _updateChat(parsedData[1][1]["message"]);
              break;
            case "chat:readMessage":
              _updateMessage(parsedData[1]);
              break;
          }
          break;
      }
    });

    c.stream.handleError((e) => print(e));
    channel = c;
  }

  _updateMessage(data) {
    print('REad message');
  }

  void _updateChats(List<dynamic> parsedData) {
    chatList.value = ChatList.fromJson(parsedData[1][1]);
  }

  void _updateOnlineTutorsList(List<dynamic> parsedData) async {
    onlineTutors.clear();
    final data = parsedData[1][1];
    final tutor = data['listTutor'];
    for (var t in tutor) {
      final tutor = await tutorService.getTutorDetail(t['userId']);
      onlineTutors.add(tutor.data!);
    }
    onlineTutors.refresh();
  }

  List _dataParser(String data) {
    int pos = 0;
    for (var c in data.characters) {
      if (c == '[' || c == '{') {
        break;
      }
      pos++;
    }
    int command = int.parse(data.substring(0, pos));
    return [command, jsonDecode(data.substring(pos))];
  }

  dispose() {
    channel?.sink.close();
  }

  void _updateChat(parsedData) {
    chats.add(Chat.fromJson(parsedData));
  }

  loadMessages(id, {int page = 1, int perPage = 25}) async {
    chats.clear();
    var url = buildUrl(
        '/message/get/$id?startTime=${DateTime.now().millisecondsSinceEpoch}&page=$page&perPage=$perPage');
    final response = await dio.get(url);
    for (var c in response.data["rows"]) {
      chats.add(Chat.fromJson(c));
    }
  }

  void chat({String? fromId, String? toId, String? content}) {
    final message = "42${jsonEncode(
      [
        "chat:sendMessage",
        {"fromId": fromId, "toId": toId, "content": content}
      ],
    )}";
    channel?.sink.add(message);
  }

  bool canChat(String tutorId) {
    return (chatList.value?.recentList ?? [])
        .any((x) => x.partner?.id == tutorId);
  }
}
