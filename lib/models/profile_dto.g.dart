// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
      name: json['name'] as String,
      country: json['country'] as String,
      birthday: json['birthday'] as String,
      learnTopics: (json['learnTopics'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      level: json['level'] as String,
      phone: json['phone'] as String,
      studySchedule: json['studySchedule'] as String,
      testPreparations: (json['testPreparations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'birthday': instance.birthday,
      'learnTopics': instance.learnTopics,
      'level': instance.level,
      'phone': instance.phone,
      'studySchedule': instance.studySchedule,
      'testPreparations': instance.testPreparations,
    };
