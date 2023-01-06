import 'package:dio/dio.dart';
import 'package:lettutor_app/models/response_entity.dart';
import 'package:lettutor_app/models/comment/comment.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/utils/types.dart';

import '../models/booking_item/booking_item.dart';
import '../models/class_history/class_history.dart';
import '../models/error/error.dart';
import '../models/schedule/tutor_schedule_info.dart';

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
        t.isFavorite = favoriteTutorIds.contains(t.userId);
        result.add(t);
      }
      return ResponseEntity(data: result, error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<TutorDetail>> getTutorDetail(String userId) async {
    try {
      print(userId);
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
        t.isFavorite = favoriteTutorIds.contains(t.userId);
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

  Future<ResponseEntity> performBecomeATeacher(FormData formData) async {
    try {
      var url = buildUrl("/tutor/register");
      await reloadToken();
      var response = await dio.post(url,
          data: formData, options: Options(contentType: 'multipart/form-data'));
      return ResponseEntity(data: response.data);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<List<BookingItem>>> getUpcomingCourse(
      {num page = 1, num perPage = 1}) async {
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

  Future<ResponseEntity<List<ClassHistory>>> getUpComings(
      num perPage, num page) async {
    try {
      int timestamp = DateTime.now()
          .subtract(const Duration(minutes: 30))
          .millisecondsSinceEpoch;
      var response = await dio.get(buildUrl(
          '/booking/list/student?perPage=$perPage&page=$page&dateTimeGte=$timestamp&orderBy=meeting&sortBy=desc'));
      var result = <ClassHistory>[];
      for (var item in response.data['data']['rows']) {
        result.add(ClassHistory.fromJson(item));
      }
      return ResponseEntity(data: result, error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<bool> saveReport(String note, String? bookingId, int reasonId) async {
    try {
      var body = {'note': note, 'reasonId': reasonId, 'bookingId': bookingId};

      final res =
          await dio.put(buildUrl('/lesson-report/save-report'), data: body);
      return true;
    } catch (e) {
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
      await dio.post(buildUrl('/user/feedbackTutor'), data: body);
      return true;
    } catch (e) {
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
      return false;
    }
  }

  Future<ResponseEntity> cancelBookingRequest(
      String? bookingId, int cancelReason, String note) async {
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

  Future<ResponseEntity<List<TutorScheduleInfo>>> getTutorSchedules(
      String tutorId) async {
    try {
      var now = DateTime.now();
      var next = now.add(Duration(days: 7));
      var url = buildUrl(
          '/schedule?tutorId=$tutorId&startTimestamp=${now.millisecondsSinceEpoch}&endTimestamp=${next.millisecondsSinceEpoch}');
      var response = await dio.get(url);
      var result = <TutorScheduleInfo>[];
      for (var item in response.data['scheduleOfTutor']) {
        result.add(TutorScheduleInfo.fromJson(item));
      }
      return ResponseEntity(data: result);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<bool> bookAClass(List<String> bookingDetailIds, String note) async {
    try {
      var url = buildUrl('/booking');
      await dio.post(url,
          data: {'scheduleDetailIds': bookingDetailIds, 'note': note});
      return true;
    } catch (e) {
      return false;
    }
  }
}
