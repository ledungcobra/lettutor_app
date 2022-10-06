import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/models/tutor_detail.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/booking.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/comment_item.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/course_preview_button.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/text_and_chips.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';
import 'package:lettutor_app/widgets/title_button.dart';

class TutorDetailScreen extends StatefulWidget {
  final TutorDetail tutor;
  late TutorService _tutorService;

  TutorDetailScreen({Key? key, required this.tutor}) : super(key: key) {
    _tutorService = GetIt.I.get<TutorService>();
  }

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> with Dimension {
  bool courseExpanded = true;
  bool commentExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Tutor Detail'),
        ),
        floatingActionButton:  IconButton( iconSize: 50,onPressed: (){}, icon: Icon(Icons.schedule_rounded, color: PRIMARY_COLOR)),
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    _header(),
                    SizedBox(
                      height: 20,
                    ),
                    _actions(),
                    SizedBox(
                      height: 20,
                    ),
                    _body(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _header() {
    return Row(
      children: [
        NetworkAvatar(
          url: widget.tutor.avatar,
          width: 80,
          height: 80,
        ),
        Column(
          children: [
            Text(widget.tutor.name),
            _stars(widget.tutor.rating.toInt()),
            Align(
                child: Container(
              height: 1.2,
              width: 120,
              color: Colors.greenAccent,
              alignment: AlignmentDirectional.centerStart,
            ))
          ],
        )
      ],
    );
  }

  Widget _stars(int count) {
    List<Widget> stars = [];
    for (var i = 0; i < count; i++) {
      stars.add(Icon(
        Icons.star,
        color: Colors.amber,
      ));
    }
    return Row(
      children: stars,
    );
  }

  _actions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleButton(
                title: 'Message',
                icon: Icons.message_outlined,
                onPress: _onPressMessageNow),
            TitleButton(
                title: 'Favorite',
                icon: Icons.favorite_outline,
                onPress: _onPressMessageNow),
            TitleButton(
                title: 'Report',
                icon: Icons.info_outline,
                onPress: _onPressMessageNow),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Button(onClick:()=>Booking.showFullModal(context, widget.tutor.id), title: 'Book')
      ],
    );
  }

  void _onPressMessageNow() {}

  Widget _body() {
    var gap = SizedBox(height: 10);
    var halfGap = SizedBox(height: 5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.tutor.description,
          style: TextStyle(fontSize: 18),
        ),
        gap,
        TextAndChips(text: 'Language', chips: widget.tutor.specialties),
        halfGap,
        Text(
          "Interest",
          style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
        ),
        halfGap,
        Text(
          widget.tutor.interests,
          style: TextStyle(fontSize: 18),
        ),
        gap,
        Text(
          "Teaching Experience",
          style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
        ),
        halfGap,
        Text(
          widget.tutor.teachingExperience,
          style: TextStyle(fontSize: 18),
        ),
        gap,
        TextAndChips(text: 'Specialties', chips: widget.tutor.specialties),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Courses",
              style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  courseExpanded = !courseExpanded;
                });
              },
              child: Text(courseExpanded ? 'Collapse' : 'Expand'),
            )
          ],
        ),
        if (courseExpanded)
          Column(
            children: widget.tutor.courses
                .map(
                  (course) => CoursePreviewButton(coursePreview: course),
                )
                .toList(),
          ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Comments",
              style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  commentExpanded = !commentExpanded;
                });
              },
              child: Text(commentExpanded ? 'Collapse' : 'Expand'),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          color: Colors.grey,
          height: 2,
        ),
        SizedBox(
          height: 20,
        ),
        if (commentExpanded) _comments()
      ],
    );
  }

  FutureBuilder<List<Comment>> _comments() {
    return FutureBuilder(
      future: widget._tutorService.getComments(widget.tutor.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.hasData) {
          var comments = snapshot.data as List<Comment>;
          return SizedBox(
            height: height(context) / 2,
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                var comment = comments[index];
                return CommentItem(comment: comment);
              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
