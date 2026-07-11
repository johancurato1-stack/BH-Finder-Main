import 'package:flutter/material.dart';
import 'package:bh_finder/core/data/models/bh_model.dart';

final landlordA = Landlord(
  name: "Robert Gomez",
  responseTime: "Usually responds in 1 hour",
  imageUrl: "https://example.com/maria.jpg",
);
final landlordB = Landlord(
  name: "Hannah Santos",
  responseTime: "Usually responds in 30 mins",
  imageUrl: "https://example.com/roberto.jpg",
);
final landlordC = Landlord(
  name: "Olivia Tores",
  responseTime: "Usually responds in 5 mins",
  imageUrl: "https://example.com/olivia.jpg",
);

class BhProvider extends ChangeNotifier {
  // We initialize the list here
  final List<BhModel> _rooms = [
    BhModel(
      id: "13",
      title: "Green Valley Boarding House",
      imageUrl:
          "https://images.unsplash.com/photo-1554995207-c18c203602cb?q=80&w=600",
      price: "2,700",
      distanceText: "4 minutes walk to Caraga State University",
      genderRules: "Mixed",
      availabilityCount: "40/40",
      totalRooms: 10,
      status: "Occupied",
      rating: 4.8,
      reviewCount: 12,
      amenities: [
        "Wi-Fi",
        "Aircon",
        "Own CR",
        "Kitchen",
        "Laundry",
        "Study Area",
        "Desk",
        "Cabinet",
        "CCTV",
        "Security",
        "Parking",
      ],
      description:
          "Find your perfect balance of affordability and comfort in our friendly, well-maintained community. We offer practical, clean, and secure rooms at a price that fits your student budget. Residents enjoy access to essential amenities including a laundry area, shared kitchen facilities, and reliable security. Located near public transport hubs and local eateries, everything you need is right at your doorstep. Schedule a viewing today and see why so many students call this place home!",
      landlord: landlordA,
    ),
    BhModel(
      id: "16",
      title: "Modern Zen Boarding House",
      imageUrl:
          "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600",
      price: "2,500",
      distanceText: "6 minutes walk to Caraga State University",
      genderRules: "Female Only",
      availabilityCount: "24/32",
      totalRooms: 8,
      status: "Pending",
      rating: 4.9,
      reviewCount: 35,
      amenities: [
        "Wi-Fi",
        "Aircon",
        "Own CR",
        "Kitchen",
        "Laundry",
        "Study Area",
        "Desk",
        "Cabinet",
        "CCTV",
        "Parking",
      ],
      description:
          "Experience stress-free living in our newly renovated boarding house, designed for those who value both privacy and convenience. Every room comes with its own private bathroom (Own CR) and air conditioning to keep you cool year-round. Enjoy the peace of mind that comes with 24/7 CCTV security and a gated entry. With a communal kitchen and an inviting common area, it’s easy to feel at home here. Move in and enjoy a modern, secure, and hassle-free lifestyle.",
      landlord: landlordB,
    ),
    BhModel(
      id: "18",
      title: "Pacific View Boarding House",
      imageUrl:
          "https://images.unsplash.com/photo-1505691938895-1758d7feb511?q=80&w=600",
      price: "2,200",
      distanceText: "12 minutes walk to Caraga State University",
      genderRules: "Male Only",
      availabilityCount: "23/24",
      totalRooms: 12,
      status: "Available",
      rating: 4.7,
      reviewCount: 22,
      amenities: [
        "Wi-Fi",
        "Aircon",
        "Own CR",
        "Kitchen",
        "Laundry",
        "Desk",
        "Cabinet",
        "CCTV",
        "Parking",
      ],
      description:
          "Looking for a quiet, productive space to ace your semester? Discover our bright and airy rooms perfectly designed for students. Each unit features a dedicated study desk, high-speed WiFi, and plenty of natural light to keep you focused. Conveniently located just a 5-minute walk from campus, you’ll spend less time commuting and more time on what matters. Featuring a shared kitchen and laundry area, this is the perfect home base for your academic journey.",
      landlord: landlordC,
    ),
  ];

  List<BhModel> get rooms => _rooms;

  // This provides only the saved ones to your SavedScreen
  List<BhModel> get savedRooms => _rooms.where((r) => r.isSaved).toList();

  void toggleSaved(BhModel room) {
    room.isSaved = !room.isSaved;
    notifyListeners(); // This notifies the SavedScreen to refresh!
  }
}
