
enum SEARCHCONDITION {
  ALL,
  GENERAL,
  EVENT,
}

class Notice {
  final int noticeId;
  final SEARCHCONDITION type;
  final String title;
  final String date;

  Notice({
    required this.noticeId,
    required this.type,
    required this.title,
    required this.date,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticeId: json['announcementId'],
      type: SEARCHCONDITION.values.firstWhere(
            (e) => e.name.toLowerCase() == json['type'].toString().toLowerCase(),
        orElse: () => SEARCHCONDITION.ALL,
      ),
      title: json['title'],
      date: json['createdAt'].toString().substring(0, 10),
    );
  }
}