import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/room_model.dart';

//============================================================================
//! MOCK ROOMS
//============================================================================

const List<RoomModel> mockRooms = [
  //==========================================================================
  //! PROPERTY 001
  //==========================================================================
  RoomModel(
    id: 'room_001',
    propertyId: 'property_001',
    roomNumber: '101',
    description: 'Cozy single room with study table.',
    price: 2000,
    capacity: 1,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
    ],
  ),

  RoomModel(
    id: 'room_002',
    propertyId: 'property_001',
    roomNumber: '102',
    description: 'Comfortable room with natural lighting.',
    price: 2300,
    capacity: 2,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800',
    ],
  ),

  RoomModel(
    id: 'room_003',
    propertyId: 'property_001',
    roomNumber: '103',
    description: 'Spacious room for two occupants.',
    price: 2700,
    capacity: 2,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800',
      'https://images.unsplash.com/photo-1464890100898-a385f744067f?w=800',
    ],
  ),

  //==========================================================================
  //! PROPERTY 002
  //==========================================================================
  RoomModel(
    id: 'room_004',
    propertyId: 'property_002',
    roomNumber: '201',
    description: 'Budget-friendly student room.',
    price: 1800,
    capacity: 1,
    genderPreference: GenderPreference.female,
    imageUrls: [
      'https://images.unsplash.com/photo-1560185007-c5ca9d2c014d?w=800',
      'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
    ],
  ),

  RoomModel(
    id: 'room_005',
    propertyId: 'property_002',
    roomNumber: '202',
    description: 'Larger room with extra storage.',
    price: 2500,
    capacity: 2,
    genderPreference: GenderPreference.female,
    imageUrls: [
      'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
    ],
  ),

  //==========================================================================
  //! PROPERTY 003
  //==========================================================================
  RoomModel(
    id: 'room_006',
    propertyId: 'property_003',
    roomNumber: '301',
    description: 'Single room with wardrobe.',
    price: 2200,
    capacity: 1,
    genderPreference: GenderPreference.male,
    imageUrls: [
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800',
    ],
  ),

  RoomModel(
    id: 'room_007',
    propertyId: 'property_003',
    roomNumber: '302',
    description: 'Standard double room.',
    price: 2600,
    capacity: 2,
    genderPreference: GenderPreference.male,
    imageUrls: [
      'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800',
      'https://images.unsplash.com/photo-1464890100898-a385f744067f?w=800',
    ],
  ),

  RoomModel(
    id: 'room_008',
    propertyId: 'property_003',
    roomNumber: '303',
    description: 'Spacious room near shared kitchen.',
    price: 2800,
    capacity: 2,
    genderPreference: GenderPreference.male,
    imageUrls: [
      'https://images.unsplash.com/photo-1560185007-c5ca9d2c014d?w=800',
      'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
    ],
  ),

  RoomModel(
    id: 'room_009',
    propertyId: 'property_003',
    roomNumber: '304',
    description: 'Premium room with larger windows.',
    price: 3200,
    capacity: 4,
    genderPreference: GenderPreference.male,
    imageUrls: [
      'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
    ],
  ),

  //==========================================================================
  //! PROPERTY 004
  //==========================================================================
  RoomModel(
    id: 'room_010',
    propertyId: 'property_004',
    roomNumber: '401',
    description: 'Modern room with a comfortable study area.',
    price: 2400,
    capacity: 2,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800',
      'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800',
    ],
  ),

  RoomModel(
    id: 'room_011',
    propertyId: 'property_004',
    roomNumber: '402',
    description: 'Bright and spacious room with good ventilation.',
    price: 2800,
    capacity: 2,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1464890100898-a385f744067f?w=800',
      'https://images.unsplash.com/photo-1560185007-c5ca9d2c014d?w=800',
    ],
  ),

  RoomModel(
    id: 'room_012',
    propertyId: 'property_004',
    roomNumber: '403',
    description: 'Premium room suitable for small groups.',
    price: 3500,
    capacity: 4,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
    ],
  ),

  //==========================================================================
  //! PROPERTY 005
  //==========================================================================
  RoomModel(
    id: 'room_013',
    propertyId: 'property_005',
    roomNumber: '501',
    description: 'Affordable room for one student.',
    price: 2100,
    capacity: 1,
    genderPreference: GenderPreference.female,
    imageUrls: [
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800',
    ],
  ),

  RoomModel(
    id: 'room_014',
    propertyId: 'property_005',
    roomNumber: '502',
    description: 'Comfortable double room.',
    price: 2600,
    capacity: 2,
    genderPreference: GenderPreference.female,
    imageUrls: [
      'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800',
      'https://images.unsplash.com/photo-1464890100898-a385f744067f?w=800',
    ],
  ),

  RoomModel(
    id: 'room_015',
    propertyId: 'property_005',
    roomNumber: '503',
    description: 'Large room with extra storage space.',
    price: 3000,
    capacity: 4,
    genderPreference: GenderPreference.female,
    imageUrls: [
      'https://images.unsplash.com/photo-1560185007-c5ca9d2c014d?w=800',
      'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
    ],
  ),

  //==========================================================================
  //! PROPERTY 006
  //==========================================================================
  RoomModel(
    id: 'room_016',
    propertyId: 'property_006',
    roomNumber: '601',
    description: 'Budget-friendly shared room.',
    price: 1900,
    capacity: 2,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
    ],
  ),

  RoomModel(
    id: 'room_017',
    propertyId: 'property_006',
    roomNumber: '602',
    description: 'Quiet room ideal for studying.',
    price: 2400,
    capacity: 2,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800',
    ],
  ),

  RoomModel(
    id: 'room_018',
    propertyId: 'property_006',
    roomNumber: '603',
    description: 'Premium room with larger floor area.',
    price: 3200,
    capacity: 4,
    genderPreference: GenderPreference.mixed,
    imageUrls: [
      'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800',
      'https://images.unsplash.com/photo-1464890100898-a385f744067f?w=800',
      'https://images.unsplash.com/photo-1560185007-c5ca9d2c014d?w=800',
    ],
  ),
];
