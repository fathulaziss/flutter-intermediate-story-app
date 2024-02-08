import 'package:flutter/foundation.dart';
import 'package:flutter_intermediate_story_app/data/api/api_service.dart';
import 'package:flutter_intermediate_story_app/data/model/response_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_detail_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_model.dart';
import 'package:flutter_intermediate_story_app/services/flavor_config.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';

class StoryRepository {
  final String tokenKey = 'token';

  Future<ResponseStoriesModel> getStories({
    int? page,
    int? size,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(tokenKey);
    final result = await ApiService().getStories(
      '$token',
      location: FlavorConfig.instance.flavor == FlavorType.paid ? 1 : 0,
      page: page,
      size: size,
    );
    return result;
  }

  Future<ResponseStoriesDetailModel> getStoriesDetail(String storyId) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(tokenKey);
    final result =
        await ApiService().getStoriesDetail(token: '$token', storyId: storyId);
    return result;
  }

  Future<ResponseModel> uploadStory({
    required List<int> bytesPhoto,
    required String fileName,
    required String description,
    double? latitude,
    double? longitude,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(tokenKey);
    final result = await ApiService().uploadStory(
      token: '$token',
      bytesPhoto: bytesPhoto,
      fileName: fileName,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );
    return result;
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    final imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final image = img.decodeImage(bytes);
    var compressQuality = 100;
    var length = imageLength;
    var newByte = <int>[];
    do {
      ///
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image!,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }
}
