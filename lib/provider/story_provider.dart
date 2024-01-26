import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/response_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_detail_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_model.dart';
import 'package:flutter_intermediate_story_app/data/repositories/story_repository.dart';
import 'package:image_picker/image_picker.dart';

class StoryProvider extends ChangeNotifier {
  StoryProvider(this.storyRepository);
  final StoryRepository storyRepository;

  bool isLoadingStories = false;
  bool isLoadingStoriesDetail = false;
  bool isLoadingStoriesUpload = false;

  XFile? imageFile;
  String? imagePath;

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

  Future<ResponseModel> uploadStory(String description) async {
    isLoadingStoriesUpload = true;

    final fileName = imageFile!.name;
    final bytes = await imageFile!.readAsBytes();
    final newBytes = await storyRepository.compressImage(bytes);

    final result = await storyRepository.uploadStory(
      bytesPhoto: newBytes,
      fileName: fileName,
      description: description,
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
}
