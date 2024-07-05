class UserResponseModel {
  UserResponseModel({
    required this.userId,
    required this.nickname,
    required this.email,
    required this.pushToken,
  });

  final int userId;
  final String nickname;
  final String email;
  final String pushToken;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
    userId: json["user"]["userId"]?? 0,
    nickname: json["user"]["nickname"] ?? '',
    email: json["user"]["email"] ?? '',
    pushToken: json["user"]["pushToken"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nickname": nickname,
    "email": email,
    "pushToken": pushToken,
  };
}