
import 'package:dio/dio.dart';

class BecomeTeacherDto{
  String? country;
  String? birthday;
  String? interests;
  String? education;
  String? experience;
  String? profession;
  String? languages;
  String? bio;
  String? targetStudent;
  String? specialties;
  MultipartFile? avatar;
  MultipartFile? video;
  String? price;

  FormData toFormData(){
    return FormData.fromMap({
      'country': country,
      'birthday': birthday,
      'interests': interests,
      'education': education,
      'experience': experience,
      'profession': profession,
      'languages': languages,
      'bio': bio,
      'targetStudent': targetStudent,
      'specialties': specialties,
      'avatar': avatar,
      'video': video,
      'price': price
    });
  }
}