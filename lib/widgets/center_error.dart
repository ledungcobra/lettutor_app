import 'package:flutter/material.dart';

class CenterError extends StatelessWidget {
  final String error;
  CenterError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error, style: TextStyle(color: Colors.red),),
    );
  }
}
