import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/mockdata/tutors.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/screens/home/widgets/upcoming_lesson.dart';
import 'package:lettutor_app/screens/home/widgets/user_info_drawer.dart';
import 'package:lettutor_app/screens/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutors/widgets/tutor_card.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/center_error.dart';
import 'package:lettutor_app/widgets/loading.dart';

class HomeScreen extends StatelessWidget {
  late TutorService tutorService;
  late BuildContext context;
  late UserService userService;

  HomeScreen({Key? key}) : super(key: key) {
    tutorService = GetIt.I.get<TutorService>();
    userService = GetIt.I.get<UserService>();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      endDrawer: UserInfoDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          FutureBuilder(
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                var userData = snapshot.data as UserInfo;
                return InkWell(
                  onTap: ()=>Scaffold.of(context).openEndDrawer(),
                  child: NetworkAvatar(
                    height: 40,
                    width: 40,
                    url: userData.user!.avatar!,
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
            future: userService.getUserInfo(),
          )
        ],
      ),
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
    var destinationScreen = TutorDetailScreen(
      tutor: listTutorDetails.first,
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => destinationScreen));
  }

  _recommendTutors(List<RecommendTutors> recommendTutors) {
    return Column(
      children: recommendTutors
          .map((tutor) => TutorCard(
              tutor: tutor.toTutor(),
              onClick: () => _handleShowTutorDetail(tutor.toTutor())))
          .toList(),
    );
  }
}
