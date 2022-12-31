// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenList _$TokenListFromJson(Map<String, dynamic> json) => TokenList(
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      refresh: json['refresh'] == null
          ? null
          : Access.fromJson(json['refresh'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenListToJson(TokenList instance) => <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };
