class InquiryModel {
  final String id;
  final String tenantName;
  final String boardingHouseName;
  final String time;
  final String? avatarUrl;

  const InquiryModel({
    required this.id,
    required this.tenantName,
    required this.boardingHouseName,
    required this.time,
    this.avatarUrl,
  });
}
