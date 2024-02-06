// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_stories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseStoriesModel _$ResponseStoriesModelFromJson(
  Map<String, dynamic> json,
) =>
    ResponseStoriesModel(
      error: json['error'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      listStory: (json['listStory'] as List<dynamic>?)
              ?.map((e) => StoriesModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ResponseStoriesModelToJson(
  ResponseStoriesModel instance,
) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
