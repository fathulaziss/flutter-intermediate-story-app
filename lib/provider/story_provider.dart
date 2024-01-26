import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_detail_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_model.dart';
import 'package:flutter_intermediate_story_app/data/repositories/story_repository.dart';

class StoryProvider extends ChangeNotifier {
  StoryProvider(this.storyRepository);
  final StoryRepository storyRepository;

  bool isLoadingStories = false;
  bool isLoadingStoriesDetail = false;

  Future<ResponseStoriesModel> getStories() async {
    isLoadingStories = true;

    final result = await storyRepository.getStories();

    isLoadingStories = false;
    notifyListeners();

    return result;
  }

  Future<ResponseStoriesDetailModel> getStoriesDetail(String storyId) async {
    isLoadingStoriesDetail = true;

    final result = await storyRepository.getStoriesDetail(storyId);

    isLoadingStoriesDetail = false;
    notifyListeners();

    return result;
  }
}
