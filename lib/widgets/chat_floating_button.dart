import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatFloatingButton extends StatefulWidget {
  final String? message;
  final Function() onClick;
  final TextStyle? messageStyle;
  final Widget? background;

  const ChatFloatingButton(
      {super.key,
      this.message,
      required this.onClick,
      this.messageStyle,
      this.background});

  @override
  State<ChatFloatingButton> createState() => _ChatFloatingButtonState();
}

class _ChatFloatingButtonState extends State<ChatFloatingButton> {
  double? _x;
  double? _y;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _x,
          top: _y,
          child: Draggable(
            feedback: Material(color: Colors.transparent, child: coreWidget()),
            childWhenDragging: Container(),
            onDragEnd: (detail) {
              setState(() {
                _x = detail.offset.dx + 20;
                _y = detail.offset.dy + 80;
                guardAgainstBoundary();
              });
            },
            child: coreWidget(),
          ),
        ),
      ],
    );
  }

  void guardAgainstBoundary() {
     if (_y! >= Get.height - 100) {
      _y = Get.height - 50;
    }
    if (_x! <= 0) {
      _x = 10;
    }
    if (_x! >= Get.width - 50) {
      _x = Get.width - 60;
    }
    if (_y! <= 0) {
      _y = 100;
    }
  }

  SizedBox coreWidget() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (widget.background != null) widget.background! else Container(),
          IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.blue,
              ),
              onPressed: widget.onClick),
          if (widget.message != null)
            Align(
              child: Text(
                widget.message!,
                style: widget.messageStyle,
              ),
            )
        ],
      ),
    );
  }
}
