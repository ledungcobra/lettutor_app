import 'package:flutter/material.dart';
import 'package:lettutor_app/widgets/loading.dart';

class LoadingImage extends StatelessWidget {
  final String? src;
  BoxFit? boxFit;
  LoadingImage({Key? key, required this.src, this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(src ?? "", loadingBuilder: (context, child, loadingProgress){
      if(loadingProgress == null){
        return  child;
      }
      return Loading();
     },fit: boxFit,);
  }
}
