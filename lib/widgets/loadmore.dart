import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoadMoreListView extends StatefulWidget {
  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final int itemCount;
  final DragStartBehavior dragStartBehavior;
  final Function funcLoadMore;
  final IndexedWidgetBuilder itemBuilder;
  final Stream<bool> isLoadMore;
  final Stream<bool>? showLoading;
  final Color loadingColor;

  const LoadMoreListView(
      {Key? key,
        this.scrollDirection = Axis.vertical,
        this.reverse = false,
        this.physics,
        this.shrinkWrap = false,
        required this.itemBuilder,
        this.itemCount = 0,
        this.dragStartBehavior = DragStartBehavior.start,
        required this.funcLoadMore,
        required this.isLoadMore,
        this.showLoading,
        this.loadingColor = Colors.blue})
      : super(key: key);

  @override
  _LoadMoreListViewState createState() => _LoadMoreListViewState();
}

class _LoadMoreListViewState extends State<LoadMoreListView> {
  late ScrollController _scrollController;
  final offsetVisibleThreshold = 10.0;
  bool _isLoad = true;

  @override
  void initState() {
    widget.isLoadMore.listen((event) {
      _isLoad = event;
    });
    _scrollController = ScrollController()..addListener(funcExcute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableGlowListViewWidget(),
              child: ListView.builder(
                controller: _scrollController,
                key: widget.key,
                itemBuilder: widget.itemBuilder,
                itemCount: widget.itemCount,
                shrinkWrap: widget.shrinkWrap,
                physics: widget.physics,
                reverse: widget.reverse,
                scrollDirection: widget.scrollDirection,
                dragStartBehavior: widget.dragStartBehavior,
              ),
            ),
          ),
          StreamBuilder<bool>(
              stream: widget.showLoading,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return Container(
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: widget.loadingColor),
                    child: const Text(
                      'Đang tải dữ liệu',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
        ],
      ),
    );
  }

  void funcExcute() {
    if (!_isLoad) return;
    if (_scrollController.offset + offsetVisibleThreshold >=
        _scrollController.position.maxScrollExtent) {
      widget.funcLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class DisableGlowListViewWidget extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
