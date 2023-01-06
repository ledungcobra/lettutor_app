import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadMoreFooter extends StatelessWidget {
  const LoadMoreFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("Nothing to load");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("Oops there are some errors occur");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("Release to load more");
        } else {
          body = Text("No more Data");
        }
        return SizedBox(
          height: 50.0,
          child: Center(child: body),
        );
      },
    );
  }
}
