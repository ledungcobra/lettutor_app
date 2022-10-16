import 'package:flutter/material.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/loading_image.dart';
import 'package:lettutor_app/widgets/loading.dart';

class CourseItem extends StatelessWidget with Dimension {
  final Course course;
  final VoidCallback onTap;

  CourseItem({Key? key, required this.course, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: SizedBox(
                  child: LoadingImage(src: course.imageUrl,),
                  width: width(context) * 0.7,
                ),
              ),
              Text(
                course.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(course.description ?? ""),
              SizedBox(height: 7),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(course.categories?[0].title ?? ""),
                  SizedBox(height: 5),
                  Text("Level ${course.level.toString()}")
                ],
              ),
              SizedBox(height: 7),
              Text('Topics ${course.topics!.length}')
            ],
          ),
        ),
      ),
    );
  }
}
