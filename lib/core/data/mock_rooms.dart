import 'package:bh_finder/core/models/room_model.dart';

//!======================================================================================================================================== G L O B A L  R O O M  L I S T  D A T A
List<RoomModel> mockRooms = [
  //* Room #1
  RoomModel(
    id: '1',
    title: 'Green Haven Boarding House',
    imageUrl:
        'https://images.unsplash.com/photo-1554995207-c18c203602cb?q=80&w=600',
    price: '2,800',
    distanceText: '5 minute walk to Caraga State University',
    genderRules: 'Female Only',
    availabilityCount: '6/6',
    status: 'Occupied',
    rating: 4.7,
    reviewCount: 24,
    amenities: [
      'wifi',
      'aircon',
      'own cr',
      'parking',
      'laundry',
      'kitchen',
      'study area',
    ],
    isSaved: true,
  ),

  //* Room #2
  RoomModel(
    id: '2',
    title: 'Blessed Home Boarding House',
    imageUrl:
        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?q=80&w=600',
    price: '3,200',
    distanceText: '8 minute walk to Caraga State University',
    genderRules: 'Female Only',
    availabilityCount: '5/8',
    status: 'Pending',
    rating: 4.5,
    reviewCount: 18,
    amenities: [
      'wifi',
      'aircon',
      'own cr',
      'parking',
      'laundry',
      'kitchen',
      'study area',
      'cctv',
    ],
    isSaved: true,
  ),

  //*Room #3
  RoomModel(
    id: '3',
    title: "Juanito's Boarding House",
    imageUrl:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=600',
    price: '3,000',
    distanceText: '12 minute walk to Caraga State University',
    genderRules: 'Male Only',
    availabilityCount: '8/12',
    status: 'Available',
    rating: 4.2,
    reviewCount: 11,
    amenities: ['wifi', 'own cr', 'parking', 'laundry', 'kitchen', 'cctv'],
    isSaved: true,
  ),
];
