import 'package:flutter_intermediate_story_app/data/api/api_service.dart';
import 'package:flutter_intermediate_story_app/data/model/response_login_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String stateKey = "state";
  final String userIdKey = "user_id";
  final String nameKey = "name";
  final String tokenKey = "token";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.getBool(stateKey) ?? false;
  }

  Future<ResponseLoginModel> login(
      {required String email, required String password}) async {
    final preferences = await SharedPreferences.getInstance();
    final result = await ApiService().login(email: email, password: password);
    if (result.error != true) {
      await preferences.setBool(stateKey, true);
      await preferences.setString(userIdKey, result.loginResult?.userId ?? '');
      await preferences.setString(nameKey, result.loginResult?.name ?? '');
      await preferences.setString(tokenKey, result.loginResult?.token ?? '');
      return result;
    } else {
      await preferences.setBool(stateKey, false);
      return result;
    }
  }

  Future<ResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await ApiService()
        .register(name: name, email: email, password: password);
    return result;
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    await preferences.remove(userIdKey);
    await preferences.remove(nameKey);
    await preferences.remove(tokenKey);
    return preferences.setBool(stateKey, false);
  }
}
