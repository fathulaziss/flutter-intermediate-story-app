import 'package:flutter_intermediate_story_app/data/model/login_result_model.dart';

class ResponseLoginModel {
  ResponseLoginModel({this.error, this.message, this.loginResult});

  factory ResponseLoginModel.fromMap(Map<String, dynamic> map) {
    return ResponseLoginModel(
      error: map['error'],
      message: map['message'],
      loginResult:
          LoginResultModel.fromMap(map['loginResult'] as Map<String, dynamic>),
    );
  }

  bool? error;
  String? message;
  LoginResultModel? loginResult;

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
      'login_result': loginResult?.toMap(),
    };
  }

  @override
  String toString() {
    return 'ResponseLoginModel(error: $error, message: $message, login_result: $loginResult)';
  }
}
