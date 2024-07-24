class LoginRequestModel {
  final String accountName;
  final String password;

  LoginRequestModel({
    required this.accountName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountName': accountName,
      'password': password,
    };
  }

}