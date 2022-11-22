import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/helper.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(getAssetImage("not_found.png"))),
            Text(
              "There no items",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
