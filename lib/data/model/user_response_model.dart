class UserResponseModel {
  UserResponseModel({
    required this.userId,
    required this.nickname,
    required this.email,
    required this.pushToken,
    required this.realName,
    required this.birth,
    required this.accountName,
    required this.invitationCode,
    required this.profileUrl,
  });

  final int userId;
  final String email;
  final String nickname;
  final String realName;
  final String birth;
  final String accountName;
  final String invitationCode;
  final String pushToken;
  final String profileUrl;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
    userId: json["user"]["userId"]?? 0,
    nickname: json["user"]["nickname"] ?? '',
    accountName: json["user"]["accountName"] ?? '',
    pushToken: json["user"]["pushToken"] ?? '',
    realName: json["user"]["realName"] ?? '',
    birth: json["user"]["birth"] ?? '',
    email: json["user"]["email"] ?? '',
    invitationCode: json["user"]["invitationCode"] ?? '',
    profileUrl: json["user"]["profileUrl"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nickname": nickname,
    "email": email,
    "pushToken": pushToken,
    "realName": realName,
    "birth": birth,
    "accountName": accountName,
    "invitationCode": invitationCode,
    "profileUrl": profileUrl,
  };
}