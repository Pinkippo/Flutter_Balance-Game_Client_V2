class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final String status;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['token']['accessToken'],
      refreshToken: json['token']['refreshToken'],
      status: json['token']['status'],
    );
  }
}
