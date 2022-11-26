import 'dart:convert';

import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/tutor_detail.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/utils/types.dart';

import '../models/booking_item.dart';
import '../models/dto/become_teacher_dto.dart';
import '../models/dto/error.dart';

class TutorService with AppAPI, CatchError {
  Future<ResponseEntity<List<Comment>>> getFeedbacksPaging(
      String userId, int page, int perPage) async {
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

  Future<List<String?>> getFavoriteTutorIds() async {
    var url = buildUrl("/tutor/more?perPage=1&page=9999999999");
    var response = await dio.get(url);
    var favoriteTutorIds = <String?>[];
    for (var tutor in response.data['favoriteTutor']) {
      favoriteTutorIds.add(Tutor.fromJson(tutor).secondId);
    }
    return favoriteTutorIds;
  }

  Future<ResponseEntity<List<Tutor>>> getTutorsPaging(
      int page, int perPage) async {
    try {
      var url = buildUrl("/tutor/more?perPage=$perPage&page=$page");
      var response = await dio.get(url);
      var result = <Tutor>[];
      var favoriteTutorIds = await getFavoriteTutorIds();
      for (var tutor in response.data['tutors']['rows']) {
        var t = Tutor.fromJson(tutor);
        t.isFavorite = favoriteTutorIds.contains(t.id);
        result.add(t);
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
      Map<dynamic, dynamic> data =
          _buildBodyFilter(page, perPage, search, filterCriteria);
      var response = await dio.post(url, data: data);
      var result = <Tutor>[];
      var favoriteTutorIds = await getFavoriteTutorIds();
      for (var tutor in response.data['rows']) {
        var t = Tutor.fromJson(tutor);
        t.isFavorite = favoriteTutorIds.contains(t.id);
        result.add(t);
      }
      return ResponseEntity(data: result);
    } catch (e) {
      return handleError(e);
    }
  }

  Map<dynamic, dynamic> _buildBodyFilter(
      int page, int perPage, String? search, FilterCriteria filterCriteria) {
    var data = {};
    data['page'] = page;
    data['perPage'] = perPage;
    var filters = {};
    data['filters'] = filters;
    filters['date'] = null;
    filters['nationality'] = filterCriteria.getNationalities();
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

  Future<ResponseEntity> performBecomeATeacher(
      BecomeTeacherDto becomeTeacherDto) async {
    try {
      var url = buildUrl("/tutor/register");
      await reloadToken();
      var response = await dio.put(url, data: becomeTeacherDto.toFormData());
      return ResponseEntity(data: response.data);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<List<BookingItem>>> getUpcomingCourse() async {
    try {
      var response = await dio.get(buildUrl(
          '/booking/next?dateTime=${DateTime.now().millisecondsSinceEpoch}'));
      var result = <BookingItem>[];
      for (var item in response.data['data']) {
        result.add(BookingItem.fromJson(item));
      }
      return ResponseEntity(data: result);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<bool> saveReport(String note, String? bookingId, int reasonId) async {
    try {
      var body = {'note': note, 'reasonId': reasonId, 'bookingId': bookingId};
      var result =
          await dio.put(buildUrl('/lesson-report/save-report'), data: body);
      print(result);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> ratingTutor(
      String content, int rating, String userId, String bookingId) async {
    try {
      var body = {
        'userId': userId,
        'rating': rating,
        'content': content,
        'bookingId': bookingId
      };
      print(body.toString());
      var result = await dio.post(buildUrl('/user/feedbackTutor'), data: body);
      print(result);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editBookingRequest(String newRequest, String? bookingId) async {
    try {
      var result = await dio.post(
          buildUrl('/booking/student-request/$bookingId'),
          data: {"studentRequest": newRequest});
      return result.data['data'].length > 0 && result.data['data'][0] == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<ResponseEntity> cancelBookingRequest(
      String bookingId, int cancelReason, String note) async {
    try {
      var result =
          await dio.delete(buildUrl('/booking/schedule-detail'), data: {
        'scheduleDetailId': bookingId,
        'cancelInfo': {'cancelReasonId': cancelReason, 'note': note}
      });
      return ResponseEntity(data: result.data['message']);
    } catch (e1) {
      var e = e1 as dynamic;
      return ResponseEntity(
          error: ErrorResponse(
              statusCode: 400,
              message: e.response!.data['message'].toString()));
    }
  }
}
