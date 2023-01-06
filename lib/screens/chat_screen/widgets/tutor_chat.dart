import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/widgets/skill_chip.dart';

import '../../../models/socket/chat_list.dart';
import '../../../models/tutor_detail/tutor_detail.dart';
import '../../../utils/types.dart';
import '../../../widgets/avatar.dart';
import '../chat_screen.dart';

class TutorChat extends StatefulWidget {
  final Partner partner;
  final void Function() onClick;

  TutorChat({
    Key? key,
    required this.partner,
    required this.onClick,
  }) : super(key: key);

  @override
  State<TutorChat> createState() => _TutorChatState();
}

class _TutorChatState extends State<TutorChat> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          widget.onClick();
        },
        child: Card(
          color: ChatScreen.clickedId.value == widget.partner.id
              ? Colors.blueGrey
              : null,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
              padding: EdgeInsets.all(10), child: Center(child: _header())),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NetworkAvatar(url: widget.partner.avatar),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.partner.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (widget.partner.isOnline ?? false)
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                    )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
