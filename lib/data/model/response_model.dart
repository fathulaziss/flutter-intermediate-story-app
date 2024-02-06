import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  ResponseModel({this.error, this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  bool? error;
  String? message;

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() {
    return 'ResponseModel(error: $error, message: $message)';
  }
}
