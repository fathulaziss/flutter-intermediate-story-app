import 'dart:convert';

import 'package:flutter_intermediate_story_app/data/model/response_login_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    const url = "https://story-api.dicoding.dev/v1/register";
    final body = {'name': name, 'email': email, 'password': password};
    final response = await http.post(Uri.parse(url), body: body);
    return ResponseModel.fromMap(jsonDecode(response.body));
  }

  Future<ResponseLoginModel> login({
    required String email,
    required String password,
  }) async {
    const url = "https://story-api.dicoding.dev/v1/login";
    final body = {'email': email, 'password': password};
    final response = await http.post(Uri.parse(url), body: body);
    return ResponseLoginModel.fromMap(jsonDecode(response.body));
  }
}
