import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';

class ResponseStoriesDetailModel {
  ResponseStoriesDetailModel({this.error, this.message, this.story});

  factory ResponseStoriesDetailModel.fromMap(Map<String, dynamic> map) {
    return ResponseStoriesDetailModel(
      error: map['error'],
      message: map['message'],
      story: map['story'] != null
          ? StoriesModel.fromMap(map['story'])
          : StoriesModel(),
    );
  }

  bool? error;
  String? message;
  StoriesModel? story;

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
      'story': story?.toMap(),
    };
  }

  @override
  String toString() {
    return 'ResponseStoriesDetailModel(error: $error, message: $message, story: $story)';
  }
}
