class RoomModel {
  final String id;
  final String bhId; // Foreign Key: Connects this room to a specific BH
  final String title;
  final String price;
  final String status;
  final String genderRules;
  final String capacity;
  final String imageUrl;
  final String description;

  RoomModel({
    required this.id,
    required this.bhId,
    required this.title,
    required this.price,
    required this.status,
    required this.genderRules,
    required this.capacity,
    required this.imageUrl,
    required this.description,
  });
}
