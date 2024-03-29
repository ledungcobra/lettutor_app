// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorDetail _$TutorDetailFromJson(Map<String, dynamic> json) => TutorDetail(
      video: json['video'] as String?,
      bio: json['bio'] as String?,
      education: json['education'] as String?,
      experience: json['experience'] as String?,
      profession: json['profession'] as String?,
      accent: json['accent'] as String?,
      targetStudent: json['targetStudent'] as String?,
      interests: json['interests'] as String?,
      languages: json['languages'] as String?,
      specialties: json['specialties'] as String?,
      rating: json['rating'] as num?,
      isNative: json['isNative'] as bool?,
      user: json['User'] == null
          ? null
          : User.fromJson(json['User'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool?,
      avgRating: json['avgRating'] as num?,
      totalFeedback: json['totalFeedback'] as int?,
    );

Map<String, dynamic> _$TutorDetailToJson(TutorDetail instance) =>
    <String, dynamic>{
      'video': instance.video,
      'bio': instance.bio,
      'education': instance.education,
      'experience': instance.experience,
      'profession': instance.profession,
      'accent': instance.accent,
      'targetStudent': instance.targetStudent,
      'interests': instance.interests,
      'languages': instance.languages,
      'specialties': instance.specialties,
      'rating': instance.rating,
      'isNative': instance.isNative,
      'User': instance.user?.toJson(),
      'isFavorite': instance.isFavorite,
      'avgRating': instance.avgRating,
      'totalFeedback': instance.totalFeedback,
    };
