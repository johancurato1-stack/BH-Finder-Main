class BhModel {
  final String id;
  final String title;
  final String imageUrl;
  final String price;
  final String distanceText;
  final String genderRules;
  final String availabilityCount;
  final String status;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  bool isSaved;

  BhModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.distanceText,
    required this.genderRules,
    required this.availabilityCount,
    required this.status,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
    this.isSaved = false,
  });
}
