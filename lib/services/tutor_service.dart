import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/tutor_detail.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';

class TutorService with AppAPI, CatchError {
  Future<List<Comment>> getComments(String tutorId) {
    return readJson(COMMENTS_FILE)
        .then((value) => value.map((v) => Comment.fromJson(v)).toList());
  }

  Future<HomeModel> getHomeModel() async {
    return HomeModel.fromJson(
        (await readObjectJson("home.json")) as Map<String, dynamic>);
  }

  Future<List<Tutor>> getTutors() {
    return readJson("tutors.json")
        .then((value) => value.map((v) => Tutor.fromJson(v)).toList());
  }

  Future<ResponseEntity<List<Tutor>>> getTutorsPaging(
      int page, int perPage) async {
    try {
      var url = buildUrl("/tutor/more?perPage=$perPage&page=$page");
      var response = await dio.get(url);
      var result = <Tutor>[];
      for (var tutor in response.data['tutors']['rows']) {
        result.add(Tutor.fromJson(tutor));
      }
      return ResponseEntity(data: result, error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<TutorDetail> getTutorDetail(String userId) {
    return readJson("tutor_detail.json").then((value) => value
        .map((v) => TutorDetail.fromJson(v))
        .toList()
        .firstWhere((tutor) => tutor.user != null && userId == tutor.user!.id));
  }
}
