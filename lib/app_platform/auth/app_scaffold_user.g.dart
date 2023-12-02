// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_scaffold_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppScaffoldUserImpl _$$AppScaffoldUserImplFromJson(
        Map<String, dynamic> json) =>
    _$AppScaffoldUserImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      authenticated: json['authenticated'] as bool,
    );

Map<String, dynamic> _$$AppScaffoldUserImplToJson(
        _$AppScaffoldUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'authenticated': instance.authenticated,
    };
