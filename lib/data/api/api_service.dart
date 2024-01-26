import 'dart:convert';
import 'dart:developer';

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

  Future<ResponseStoriesModel> getStories(String token) async {
    const url = 'https://story-api.dicoding.dev/v1/stories';

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
    final url = 'https://story-api.dicoding.dev/v1/stories/:$storyId';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    log('cek response : ${jsonDecode(response.body)}');
    return ResponseStoriesDetailModel.fromMap(jsonDecode(response.body));
  }
}
