class RegisterRequestModel {
  final String accountName;
  final String password;
  final String realName;
  final String birth;
  final String email;
  final String pushToken;
  final bool isCheckedMarketing;
  final String profileUrl;
  final String? nickName;

  RegisterRequestModel({
    required this.accountName,
    required this.password,
    required this.realName,
    required this.birth,
    required this.email,
    required this.pushToken,
    required this.isCheckedMarketing,
    required this.profileUrl,
    required this.nickName,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountName': accountName,
      'password': password,
      'realName': realName,
      'birth': birth,
      'email': email,
      'pushToken': pushToken,
      'isCheckedMarketing': isCheckedMarketing,
      'profileUrl': profileUrl,
      'nickName': nickName,
    };
  }
}
