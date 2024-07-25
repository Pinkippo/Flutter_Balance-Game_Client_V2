class RegisterResponseModel {
  final String accessToken;
  final String refreshToken;

  RegisterResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      accessToken: json['token']['accessToken'],
      refreshToken: json['token']['refreshToken'],
    );
  }
}
