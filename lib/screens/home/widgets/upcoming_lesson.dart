import 'package:flutter/material.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/screens/video_call/video_call_screen.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/button.dart';

class UpCommingLession extends StatelessWidget with Dimension{
  Header header;

  UpCommingLession(this.header);

  @override
  Widget build(BuildContext context) {
    var textWhiteStyle =  TextStyle(color: Colors.white, fontSize: 25);
    return Container(
      width: double.infinity,
      height: height(context) * 0.35,
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(header.totalLessonTime ?? "", style:textWhiteStyle,),
            Text(header.upcomingLesson?.timeStart  ?? "Not available", style: textWhiteStyle,),
            Button(title: 'Enter lesson room', onClick: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => VideoCallScreen() ));
            }, color: Colors.white,textColor: PRIMARY_COLOR,full: false, radius: 20,)
          ],
        ),
      ),
    );
  }
}
