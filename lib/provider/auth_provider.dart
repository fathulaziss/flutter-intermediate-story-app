import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/response_login_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response_model.dart';
import 'package:flutter_intermediate_story_app/data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  AuthProvider(this.authRepository);

  bool isLoadingLogin = false;
  bool isLoadingRegister = false;
  bool isLoadingLogout = false;
  bool isLoggedIn = false;

  Future<ResponseLoginModel> login({
    required String email,
    required String password,
  }) async {
    isLoadingLogin = true;
    notifyListeners();

    final result = await authRepository.login(
      email: email,
      password: password,
    );

    if (result.error != true) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    isLoadingLogin = false;
    notifyListeners();

    return result;
  }

  Future<ResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoadingRegister = true;
    notifyListeners();

    final result = await authRepository.register(
        name: name, email: email, password: password);

    isLoadingRegister = false;
    notifyListeners();

    return result;
  }

  Future<void> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    await authRepository.logout();
    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogout = false;
    notifyListeners();
  }
}
