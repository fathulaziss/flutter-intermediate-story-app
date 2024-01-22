import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  AuthProvider(this.authRepository);
}
