class Theme {
  final int themeId;
  final String theme;
  final String iconUrl;

  Theme({
    required this.themeId,
    required this.theme,
    required this.iconUrl,
  });

  factory Theme.fromJson(Map<String, dynamic> json) {
    return Theme(
      themeId: json['themeId'],
      theme: json['theme'],
      iconUrl: json['iconUrl'],
    );
  }
}
