import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/history_item.dart';
import 'package:lettutor_app/screens/history/widgets/history_item.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../widgets/loading.dart';

class HistoryScreen extends StatefulWidget {
  UserService _userService = Get.find();

  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with HandleUIError {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder(
        future: widget._userService.getHistories(1000, 1),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.hasData) {
            var response = snapshot.data!;
            if (response.hasError) {
              handleError(response.error!);
              return Container();
            }
            return _listHistory(response.data!);
          }
          return Center(child: Loading());
        },
      ),
    );
  }

  Widget _listHistory(List<ClassHistory> histories) {
    return ListView(
      children:
          histories.map((history) => HistoryItem(history: history)).toList(),
    );
  }
}
