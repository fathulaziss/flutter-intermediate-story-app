import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/response_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_detail_model.dart';
import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';
import 'package:flutter_intermediate_story_app/data/repositories/story_repository.dart';
import 'package:image_picker/image_picker.dart';

class StoryProvider extends ChangeNotifier {
  StoryProvider(this.storyRepository);
  final StoryRepository storyRepository;

  bool isLoadingStories = false;
  bool isLoadingStoriesDetail = false;
  bool isLoadingStoriesUpload = false;

  List<StoriesModel> listStory = [];

  int? pageItems = 1;
  int sizeItems = 10;

  XFile? imageFile;
  String? imagePath;

  Future<void> getStories() async {
    try {
      if (pageItems == 1) {
        isLoadingStories = true;
        listStory.clear();
        notifyListeners();
      }

      final result =
          await storyRepository.getStories(page: pageItems, size: sizeItems);

      listStory.addAll(result.listStory);

      if (result.listStory.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }

      isLoadingStories = false;
      notifyListeners();
    } catch (e) {
      isLoadingStories = false;
      notifyListeners();
    }
  }

  Future<ResponseStoriesDetailModel> getStoriesDetail(String storyId) async {
    isLoadingStoriesDetail = true;

    final result = await storyRepository.getStoriesDetail(storyId);

    isLoadingStoriesDetail = false;
    notifyListeners();

    return result;
  }

  Future<ResponseModel> uploadStory({
    required String description,
    double? latitude,
    double? longitude,
  }) async {
    isLoadingStoriesUpload = true;
    notifyListeners();

    final fileName = imageFile!.name;
    final bytes = await imageFile!.readAsBytes();
    final newBytes = await storyRepository.compressImage(bytes);

    final result = await storyRepository.uploadStory(
      bytesPhoto: newBytes,
      fileName: fileName,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );

    isLoadingStoriesUpload = false;
    notifyListeners();

    if (result.error != true) {
      setImageFile(null);
      setImagePath(null);
    }

    return result;
  }

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void setPageItem(int value) {
    pageItems = value;
    notifyListeners();
  }
}
