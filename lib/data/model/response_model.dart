class ResponseModel {
  ResponseModel({this.error, this.message});

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(error: map['error'], message: map['message']);
  }

  bool? error;
  String? message;

  Map<String, dynamic> toMap() {
    return {'error': error, 'message': message};
  }

  @override
  String toString() {
    return 'ResponseModel(error: $error, message: $message)';
  }
}
