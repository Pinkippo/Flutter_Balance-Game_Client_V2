class Writer {
  final int userId;
  final String nickName;

  Writer({
    required this.userId,
    required this.nickName,
  });

  factory Writer.fromJson(Map<String, dynamic> json) {
    return Writer(
      userId: json['userId'],
      nickName: json['nickName'],
    );
  }
}