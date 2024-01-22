import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String stateKey = "state";
  final String userKey = "user";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.getBool(stateKey) ?? false;
  }
}
