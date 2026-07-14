import 'package:bh_finder/core/data/models/room_model.dart';

class RoomDataSource {
  static final List<RoomModel> allRooms = [
    // Rooms for "Green Valley" (ID: 13)
    RoomModel(
      id: "r1",
      bhId: "13",
      title: "Room 1A",
      price: "3,500",
      status: "Available",
      genderRules: "Male",
      capacity: "1/1",
      imageUrl:
          "https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&q=80&w=300",
      description: "This room is very good!",
    ),
    RoomModel(
      id: "r2",
      bhId: "13",
      title: "Room 2A",
      price: "2,200",
      status: "Reserved",
      genderRules: "Male",
      capacity: "1/2",
      imageUrl:
          "https://images.unsplash.com/photo-1505691938895-1758d7feb511?q=80&w=600",
      description: "This room is very good!",
    ),
    RoomModel(
      id: "r3",
      bhId: "13",
      title: "Room 3A",
      price: "2,200",
      status: "Occupied",
      genderRules: "Male",
      capacity: "2/2",
      imageUrl:
          "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600",
      description: "This room is very good!",
    ),
    // Rooms for "Modern Zen" (ID: 16)
    RoomModel(
      id: "r2",
      bhId: "16",
      title: "Standard Shared",
      price: "2,200",
      status: "Available",
      genderRules: "Female",
      capacity: "1/2",
      imageUrl:
          "https://images.unsplash.com/photo-1505691938895-1758d7feb511?q=80&w=600",
      description: "This room is very good!",
    ),
    // Rooms for "Pacific View" (ID: 18)
    RoomModel(
      id: "r3",
      bhId: "18",
      title: "Budget Bed Space",
      price: "1,500",
      status: "Occupied",
      genderRules: "Mixed",
      capacity: "2/2",
      imageUrl:
          "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600",
      description: "This room is very good!",
    ),
  ];
}
