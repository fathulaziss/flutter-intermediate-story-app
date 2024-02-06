// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLoginModel _$ResponseLoginModelFromJson(Map<String, dynamic> json) =>
    ResponseLoginModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      loginResult: json['loginResult'] == null
          ? null
          : LoginResultModel.fromJson(
              json['loginResult'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ResponseLoginModelToJson(ResponseLoginModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'loginResult': instance.loginResult,
    };
