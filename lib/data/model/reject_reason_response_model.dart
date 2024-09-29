class RejectReasonResponseModel {
  final int blockUserHistoryId;
  final String adminName;
  final int userId;
  final String reason;

  RejectReasonResponseModel({
    required this.blockUserHistoryId,
    required this.adminName,
    required this.userId,
    required this.reason,
  });

  // Factory constructor to create an instance from JSON
  factory RejectReasonResponseModel.fromJson(Map<String, dynamic> json) {
    return RejectReasonResponseModel(
      blockUserHistoryId: json['blockUserHistoryId'] as int,
      adminName: json['adminName'] as String,
      userId: json['userId'] as int,
      reason: json['reason'] as String,
    );
  }

  // Method to convert an instance to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'blockUserHistoryId': blockUserHistoryId,
      'adminName': adminName,
      'userId': userId,
      'reason': reason,
    };
  }
}