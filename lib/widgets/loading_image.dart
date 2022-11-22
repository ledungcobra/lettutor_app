import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/widgets/loading.dart';

class LoadingImage extends StatelessWidget {
  final String? src;
  BoxFit? boxFit;
  LoadingImage({Key? key, required this.src, this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height/4,
      child: Image.network(src ?? "", loadingBuilder: (context, child, loadingProgress){
        if(loadingProgress == null){
          return  child;
        }
        return Loading();
       },fit: boxFit,),
    );
  }
}
