class UserResponseModel {
  UserResponseModel({
    required this.userId,
    required this.nickname,
    required this.email,
    required this.pushToken,
    required this.realName,
    required this.birth,
    required this.phoneNumber,
    required this.invitationCode,
  });

  final int userId;
  final String email;
  final String nickname;
  final String realName;
  final String birth;
  final String phoneNumber;
  final String invitationCode;
  final String pushToken;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
    userId: json["user"]["userId"]?? 0,
    nickname: json["user"]["nickname"] ?? '',
    email: json["user"]["email"] ?? '',
    pushToken: json["user"]["pushToken"] ?? '',
    realName: json["user"]["realName"] ?? '',
    birth: json["user"]["birth"] ?? '',
    phoneNumber: json["user"]["phoneNumber"] ?? '',
    invitationCode: json["user"]["invitationCode"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nickname": nickname,
    "email": email,
    "pushToken": pushToken,
    "realName": realName,
    "birth": birth,
    "phoneNumber": phoneNumber,
    "invitationCode": invitationCode,
  };
}