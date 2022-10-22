import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/history/history.dart';
import 'package:lettutor_app/screens/history/widgets/history_item.dart';
import 'package:lettutor_app/services/user_service.dart';

class HistoryScreen extends StatefulWidget {
  UserService _userService = Get.find();

  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder(
        future: widget._userService.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Container();
          }
          if (snapshot.hasData) {
            return _listHistory(snapshot.data as List<History>);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _listHistory(List<History> histories) {
    return ListView(
      children:
          histories.map((history) => HistoryItem(history: history)).toList(),
    );
  }
}
