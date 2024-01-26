import 'package:flutter_intermediate_story_app/data/api/api_service.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_detail_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryRepository {
  final String tokenKey = 'token';

  Future<ResponseStoriesModel> getStories() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(tokenKey);
    final result = await ApiService().getStories('$token');
    return result;
  }

  Future<ResponseStoriesDetailModel> getStoriesDetail(String storyId) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(tokenKey);
    final result =
        await ApiService().getStoriesDetail(token: '$token', storyId: storyId);
    return result;
  }
}
