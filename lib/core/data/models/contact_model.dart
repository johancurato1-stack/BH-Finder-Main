class ContactModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isOnline;

  ContactModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.isOnline = false,
  });
}
