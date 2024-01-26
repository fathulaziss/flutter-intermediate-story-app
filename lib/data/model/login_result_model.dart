class LoginResultModel {
  LoginResultModel({
    this.userId,
    this.name,
    this.token,
  });

  factory LoginResultModel.fromMap(Map<String, dynamic> map) {
    return LoginResultModel(
      userId: map['userId'],
      name: map['name'],
      token: map['token'],
    );
  }

  String? userId;
  String? name;
  String? token;

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'name': name, 'token': token};
  }

  @override
  String toString() {
    return 'LoginResultModel(userId: $userId, name: $name, token: $token)';
  }
}
