class VersionModel {
  final String currentVersion;
  final String minimumVersion;
  final String preferVersion;

  VersionModel ({
    required this.currentVersion,
    required this.minimumVersion,
    required this.preferVersion
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
      currentVersion: json["version"]["currentVersion"] ?? '',
      minimumVersion: json["version"]["minimumVersion"] ?? '',
      preferVersion: json["version"]["preferVersion"] ?? '',
    );
}