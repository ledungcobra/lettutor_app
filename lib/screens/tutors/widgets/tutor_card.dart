import 'package:flutter/material.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/skill_chip.dart';

class TutorCard extends StatelessWidget {
  final Tutor tutor;
  final void Function() onClick;

  TutorCard({Key? key, required this.tutor, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [_header(), _body(), _footer()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircleAvatar(
              backgroundImage: NetworkImage(tutor.avatar?? ""), radius: 100),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 1,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tutor.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(tutor.rating!.toStringAsFixed(2) ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SkillChip(
                        selected: true, value: tutor.getSpecialties()[index]),
                    itemCount: tutor.getSpecialties().length,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.only(right: 13.0),
      child: Text(
        tutor.bio ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Roboto',
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
            OutlinedButton(onPressed: () {}, child: Text('Book')),
          ],
        )
      ],
    );
  }
}
