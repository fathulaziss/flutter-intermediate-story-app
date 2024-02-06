import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_stories_model.g.dart';

@JsonSerializable()
class ResponseStoriesModel {
  ResponseStoriesModel({
    this.error = false,
    this.message = '',
    this.listStory = const [],
  });

  factory ResponseStoriesModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseStoriesModelFromJson(json);

  bool error;
  String message;
  List<StoriesModel> listStory;

  Map<String, dynamic> toJson() => _$ResponseStoriesModelToJson(this);

  @override
  String toString() {
    return 'ResponseStoriesModel(error: $error, message: $message, listStory: $listStory)';
  }
}
