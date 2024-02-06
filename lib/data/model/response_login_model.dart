import 'package:flutter_intermediate_story_app/data/model/login_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_login_model.g.dart';

@JsonSerializable()
class ResponseLoginModel {
  ResponseLoginModel({this.error, this.message, this.loginResult});

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseLoginModelFromJson(json);

  bool? error;
  String? message;
  LoginResultModel? loginResult;

  Map<String, dynamic> toJson() => _$ResponseLoginModelToJson(this);

  @override
  String toString() {
    return 'ResponseLoginModel(error: $error, message: $message, login_result: $loginResult)';
  }
}
