import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/request/certificate_data.dart';
import '../../utils/types.dart';

class BecomeTutorController with HandleUIError {
  String name = '';
  String country = '';
  String birthday = '';
  String interests = "";
  String education = "";
  String experience = "";
  String profession = "";
  String languages = "";
  String bio = "";
  String targetStudent = "";
  String specialties = "";
  String avatar = "";
  String video = "";
  CertificateData? certificate;
  final step = 1.obs;

  Future<d.FormData> buildDto() async {
    validateDto();
    return d.FormData.fromMap({
      'name': name,
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
      'avatar': await d.MultipartFile.fromFile(avatar),
      'video': await d.MultipartFile.fromFile(video),
      'price': 50000,
      'certificate': d.MultipartFile.fromBytes(certificate!.data.toList()),
      'certificateMapping': [certificate?.toJson() ?? {}]
    });
  }

  void validateDto() {
    _notEmpty(name, 'Name is required');
    _notEmpty(country, 'Country is required');
    _notEmpty(birthday, 'Birthday should be selected');
    _notEmpty(interests, 'Interests is required');
    _notEmpty(education, 'Education is required');
    _notEmpty(experience, 'Experience is required');
    _notEmpty(profession, 'Profession is required');
    _notEmpty(languages, 'Languages is required');
    _notEmpty(bio, 'Bio is required');
    _notEmpty(targetStudent, 'Target Student is required');
    _notEmpty(specialties, 'Specialties is required');
    _notEmpty(avatar, 'Avatar is required');
    _notEmpty(video, 'Video is required');
    _notNull(certificate  ,'Certificate is required');
  }

  _notNull(Object? field, String errorMessage){
    if(field == null){
      throw FormValidationException(errorMessage);
    }
  }

  _notEmpty(String field, String errorMessage) {
    if (field.isEmpty) {
      throw FormValidationException(errorMessage);
    }
  }
}
