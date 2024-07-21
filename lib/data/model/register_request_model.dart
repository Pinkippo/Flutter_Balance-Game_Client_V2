class RegisterRequestModel {
  final String email;
  final String password;
  final String realName;
  final String birth;
  final String phoneNumber;
  final String pushToken;
  final bool isCheckedMarketing;
  final String profileUrl;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.realName,
    required this.birth,
    required this.phoneNumber,
    required this.pushToken,
    required this.isCheckedMarketing,
    required this.profileUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'realName': realName,
      'birth': birth,
      'phoneNumber': phoneNumber,
      'pushToken': pushToken,
      'isCheckedMarketing': isCheckedMarketing,
      'profileUrl': profileUrl,
    };
  }
}
