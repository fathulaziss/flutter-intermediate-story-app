import 'dart:convert';

import 'package:flutter_intermediate_story_app/data/model/response_login_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_detail_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_stories_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    const url = 'https://story-api.dicoding.dev/v1/register';
    final body = {'name': name, 'email': email, 'password': password};
    final response = await http.post(Uri.parse(url), body: body);
    return ResponseModel.fromMap(jsonDecode(response.body));
  }

  Future<ResponseLoginModel> login({
    required String email,
    required String password,
  }) async {
    const url = 'https://story-api.dicoding.dev/v1/login';
    final body = {'email': email, 'password': password};
    final response = await http.post(Uri.parse(url), body: body);
    return ResponseLoginModel.fromMap(jsonDecode(response.body));
  }

  Future<ResponseStoriesModel> getStories(
    String token, {
    int location = 0,
    int? page,
    int? size,
  }) async {
    final url =
        'https://story-api.dicoding.dev/v1/stories?location=$location${page != null ? '&page=$page' : ''}${size != null ? '&size=$size' : ''}';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    return ResponseStoriesModel.fromMap(jsonDecode(response.body));
  }

  Future<ResponseStoriesDetailModel> getStoriesDetail({
    required String token,
    required String storyId,
  }) async {
    final url = 'https://story-api.dicoding.dev/v1/stories/$storyId';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    return ResponseStoriesDetailModel.fromMap(jsonDecode(response.body));
  }

  Future<ResponseModel> uploadStory({
    required String token,
    required List<int> bytesPhoto,
    required String fileName,
    required String description,
  }) async {
    const url = 'https://story-api.dicoding.dev/v1/stories';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final multiPartFile =
        http.MultipartFile.fromBytes('photo', bytesPhoto, filename: fileName);
    final fields = {'description': description};
    final headers = {
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final streamedResponse = await request.send();
    final statusCode = streamedResponse.statusCode;

    final responseList = await streamedResponse.stream.toBytes();
    final responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      return ResponseModel.fromMap(jsonDecode(responseData));
    } else {
      throw Exception('Upload file error');
    }
  }
}
