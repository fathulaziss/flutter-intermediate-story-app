import 'package:json_annotation/json_annotation.dart';

part 'login_result_model.g.dart';

@JsonSerializable()
class LoginResultModel {
  LoginResultModel({
    this.userId,
    this.name,
    this.token,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultModelFromJson(json);

  String? userId;
  String? name;
  String? token;

  Map<String, dynamic> toJson() => _$LoginResultModelToJson(this);

  @override
  String toString() {
    return 'LoginResultModel(userId: $userId, name: $name, token: $token)';
  }
}
