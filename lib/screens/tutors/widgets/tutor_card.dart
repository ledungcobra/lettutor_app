import 'package:flutter/material.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/skill_chip.dart';

import '../../../utils/types.dart';
import '../../../widgets/avatar.dart';

class TutorCard extends StatefulWidget {

  final Tutor tutor;
  final void Function() onClick;
  final Likable likable;

  TutorCard({Key? key,
    required this.tutor,
    required this.onClick, required this.likable,
  })
      : super(key: key);

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
        NetworkAvatar(url: widget.tutor.avatar),
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
                    widget.tutor.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(widget.tutor.rating?.toStringAsFixed(2) ?? ''),
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
                    itemBuilder: (context, index) =>
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: SkillChip(
                              selected: true,
                              value: widget.tutor.getSpecialties()[index]
                                  .description ?? ""),
                        ),
                    itemCount: widget.tutor
                        .getSpecialties()
                        .length,
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
        widget.tutor.bio ?? "",
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
            IconButton(
                onPressed: onLikeClick,
                icon: Icon(
                  widget.tutor.isFavorite ? Icons.favorite : Icons
                      .favorite_border,
                  color: Colors.redAccent,
                )),
            OutlinedButton(onPressed: () {}, child: Text('Book')),
          ],
        )
      ],
    );
  }

  onLikeClick() async {
    await widget.likable.like(widget.tutor);
    setState(() {});
  }
}
