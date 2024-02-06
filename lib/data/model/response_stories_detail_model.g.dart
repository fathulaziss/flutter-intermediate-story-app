// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_stories_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseStoriesDetailModel _$ResponseStoriesDetailModelFromJson(
  Map<String, dynamic> json,
) =>
    ResponseStoriesDetailModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      story: json['story'] == null
          ? null
          : StoriesModel.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseStoriesDetailModelToJson(
  ResponseStoriesDetailModel instance,
) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
