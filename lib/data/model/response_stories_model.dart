import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';

class ResponseStoriesModel {
  ResponseStoriesModel({this.error, this.message, this.listStory});

  factory ResponseStoriesModel.fromMap(Map<String, dynamic> map) {
    return ResponseStoriesModel(
      error: map['error'],
      message: map['message'],
      listStory: map['listStory'] != null
          ? List<StoriesModel>.from(
              (map['listStory'] as List).map((e) {
                return StoriesModel.fromMap(e);
              }),
            )
          : [],
    );
  }

  bool? error;
  String? message;
  List<StoriesModel>? listStory;

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
      'listStory': List.from(listStory!.map((e) => e.toMap())),
    };
  }

  @override
  String toString() {
    return 'ResponseStoriesModel(error: $error, message: $message, listStory: $listStory)';
  }
}
