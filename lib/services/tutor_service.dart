import 'dart:convert';

import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/tutor_detail.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/utils/types.dart';

import '../models/dto/become_teacher_dto.dart';

class TutorService with AppAPI, CatchError {

  Future<ResponseEntity<List<Comment>>> getFeedbacksPaging(String userId,
      int page, int perPage) async {
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

  Future<ResponseEntity<List<Tutor>>> getTutorsPaging(int page,
      int perPage) async {
    try {
      var url = buildUrl("/tutor/more?perPage=$perPage&page=$page");
      var response = await dio.get(url);
      var result = <Tutor>[];
      var favoriteTutorIds = <String?>[];
      for(var tutor in response.data['favoriteTutor']){
        favoriteTutorIds.add(Tutor.fromJson(tutor).secondId);
      }
      for (var tutor in response.data['tutors']['rows']) {
        var parseTutor = Tutor.fromJson(tutor);
        if(favoriteTutorIds.contains(parseTutor.id)){
          parseTutor.isFavorite = true;
        }
        result.add(parseTutor);
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

  Future<ResponseEntity<List<Tutor>>> searchTutor(String? search,
      FilterCriteria filterCriteria, int page, int perPage) async {
    try {
      var url = buildUrl("/tutor/search");
      Map<dynamic, dynamic> data = _buildBodyFilter(page, perPage, search,filterCriteria);
      print('Body ${jsonEncode(data)}');
      var response = await dio.post(url, data: data);
      var result = <Tutor>[];
      for (var tutor in response.data['rows']) {
        result.add(Tutor.fromJson(tutor));
      }
      return ResponseEntity(data: result);
    } catch (e) {
      return handleError(e);
    }
  }

  Map<dynamic, dynamic> _buildBodyFilter(int page, int perPage,
      String? search, FilterCriteria filterCriteria) {
    var data = {};
    data['page'] = page;
    data['perPage'] = perPage;
    var filters = {};
    data['filters'] = filters;
    filters['date'] = null;
    filters['nationality'] =  filterCriteria.getNationalities();
    filters['specialties'] = filterCriteria.getSpecialties();
    filters['tutoringTimeAvailable'] = [null, null];
    data['date'] = null;
    if (search != null && search.isNotEmpty) {
      data['search'] = search;
    }
    return data;
  }

  // TODO using this
  Future<ResponseEntity> performLike(String userId) async {
    try {
      var url = buildUrl("/user/manageFavoriteTutor");
      Map<dynamic, dynamic> data = {'tutorId': userId};
      var response = await dio.post(url, data: data);
      return ResponseEntity(data: response.data);
    } catch (e) {
      return handleError(e);
    }
  }
  Future<ResponseEntity> performBecomeATeacher(BecomeTeacherDto becomeTeacherDto) async {
    try {
      var url = buildUrl("/tutor/register");
      await reloadToken();
      var response = await dio.put(url, data: becomeTeacherDto.toFormData());
      return ResponseEntity(data: response.data);
    } catch (e) {
      return handleError(e);
    }
  }
}
