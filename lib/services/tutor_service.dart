import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/tutor_detail.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';

class TutorService with AppAPI, CatchError {

  Future<ResponseEntity<List<Comment>>> getFeedbacksPaging(String userId, int page, int perPage) async {
    try {
      var url = buildUrl("/feedback/v2/$userId?perPage=$perPage&page=$page");
      var response = await dio.get(url);
      var result = <Comment>[];
      for (var tutor in response.data['data']['rows']) {
        result.add(Comment.fromJson(tutor));
      }
      return ResponseEntity(data: result, error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<HomeModel> getHomeModel() async {
    return HomeModel.fromJson(
        (await readObjectJson("home.json")) as Map<String, dynamic>);
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

  Future<ResponseEntity<TutorDetail>> getTutorDetail(String userId) async {
    try {
      var url = buildUrl("/tutor/$userId");
      var response = await dio.get(url);
      return ResponseEntity(
          data: TutorDetail.fromJson(response.data), error: null);
    } catch (e) {
      return handleError(e);
    }
  }
}
