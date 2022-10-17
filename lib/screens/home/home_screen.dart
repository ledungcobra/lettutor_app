import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/mockdata/tutors.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/home/widgets/upcoming_lesson.dart';
import 'package:lettutor_app/screens/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutors/widgets/tutor_card.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/widgets/center_error.dart';
import 'package:lettutor_app/widgets/loading.dart';

class HomeScreen extends StatelessWidget {
  late TutorService tutorService;
  late BuildContext context;
  HomeScreen({Key? key}) : super(key: key) {
    tutorService = GetIt.I.get<TutorService>();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Home'),
          // NetworkAvatar(
          //   url: '',
          //   height: 40,
          //   width: 40,
          // )
        ],
      )),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CenterError(error: snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return _homeBody(snapshot.data!);
          }
          return Loading();
        },
        future: tutorService.getHomeModel(),
      ),
    );
  }

  Widget _homeBody(HomeModel data) {
    return ListView(children: [
      UpCommingLession(data.header!),
      _recommendTutors(data.recommendTutors ?? [])
    ]);
  }
  void _handleShowTutorDetail(Tutor tutor) {
    var destinationScreen = TutorDetailScreen(tutor: listTutorDetails.first,);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => destinationScreen));
  }
  _recommendTutors(List<RecommendTutors> recommendTutors) {
    return Column(children: recommendTutors.map((tutor)=> TutorCard(tutor: tutor.toTutor(), onClick: ()=>_handleShowTutorDetail( tutor.toTutor()))).toList(),);
  }
}
