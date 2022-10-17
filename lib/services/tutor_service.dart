import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';

class TutorService {
  Future<List<Comment>> getComments(String tutorId) {
    return readJson(COMMENTS_FILE)
        .then((value) => value.map((v) => Comment.fromJson(v)).toList());
  }

  Future<HomeModel> getHomeModel() async {
    return HomeModel.fromJson(
        (await readObjectJson("home.json")) as Map<String, dynamic>);
  }
}
