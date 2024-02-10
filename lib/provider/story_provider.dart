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

  final List<StoriesModel> _listStory = [];
  List<StoriesModel> get listStory => _listStory;

  int? pageItems = 1;
  int sizeItems = 10;

  XFile? imageFile;
  String? imagePath;

  Future<void> getInitStories() async {
    isLoadingStories = true;

    final result = await storyRepository.getStories(page: 1, size: sizeItems);

    if (result.listStory.isNotEmpty) {
      _listStory.addAll(result.listStory);
    }

    isLoadingStories = false;
    notifyListeners();
  }

  Future<void> getStories() async {
    isLoadingStories = true;
    notifyListeners();

    final result = await storyRepository.getStories(page: 1, size: sizeItems);

    if (result.listStory.isNotEmpty) {
      _listStory
        ..clear()
        ..addAll(result.listStory);
      notifyListeners();
    }

    isLoadingStories = false;
    notifyListeners();
  }

  Future<void> getMoreStories() async {
    isLoadingStories = true;
    notifyListeners();

    final result =
        await storyRepository.getStories(page: pageItems, size: sizeItems);

    if (result.listStory.isNotEmpty) {
      for (final item in result.listStory) {
        if (!_listStory.map((e) => e.id).toList().contains(item.id)) {
          _listStory.add(item);
        }
      }
    }

    if (result.listStory.length < sizeItems) {
      pageItems = pageItems;
    } else {
      pageItems = pageItems! + 1;
    }

    isLoadingStories = false;
    notifyListeners();
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
