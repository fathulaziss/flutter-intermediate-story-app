import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_stories_detail_model.g.dart';

@JsonSerializable()
class ResponseStoriesDetailModel {
  ResponseStoriesDetailModel({this.error, this.message, this.story});

  factory ResponseStoriesDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseStoriesDetailModelFromJson(json);

  bool? error;
  String? message;
  StoriesModel? story;

  Map<String, dynamic> toJson() => _$ResponseStoriesDetailModelToJson(this);

  @override
  String toString() {
    return 'ResponseStoriesDetailModel(error: $error, message: $message, story: $story)';
  }
}
