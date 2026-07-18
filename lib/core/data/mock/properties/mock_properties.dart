import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/property_model.dart';

//============================================================================
//! MOCK PROPERTIES
//============================================================================

const List<PropertyModel> mockProperties = [
  PropertyModel(
    id: 'property_001',
    landlordId: 'landlord_001',
    title: 'Sunrise Boarding House',
    description:
        'Affordable boarding house near the university with complete amenities.',
    address: 'Purok 3, Ampayon, Butuan City',
    latitude: 8.9475,
    longitude: 125.5312,
    imageUrls: [
      'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
    ],
    amenities: [Amenity.wifi, Amenity.kitchen, Amenity.cctv, Amenity.laundry],
    genderPreference: GenderPreference.mixed,
    favoriteCount: 28,
    status: PropertyStatus.available,
  ),

  PropertyModel(
    id: 'property_002',
    landlordId: 'landlord_001',
    title: 'Maple Student Lodge',
    description: 'Walking distance from CSU campus.',
    address: 'Villa Kananga, Butuan City',
    latitude: 8.9514,
    longitude: 125.5280,
    imageUrls: [
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800',
    ],
    amenities: [Amenity.wifi, Amenity.parking, Amenity.cctv],
    genderPreference: GenderPreference.female,
    favoriteCount: 41,
    status: PropertyStatus.available,
  ),

  PropertyModel(
    id: 'property_003',
    landlordId: 'landlord_002',
    title: 'Green Haven Dormitory',
    description: 'Clean and quiet environment for students.',
    address: 'Ampayon, Butuan City',
    latitude: 8.9492,
    longitude: 125.5303,
    imageUrls: [
      'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800',
      'https://images.unsplash.com/photo-1464890100898-a385f744067f?w=800',
    ],
    amenities: [Amenity.wifi, Amenity.studyArea, Amenity.waterIncluded],
    genderPreference: GenderPreference.male,
    favoriteCount: 17,
    status: PropertyStatus.available,
  ),

  PropertyModel(
    id: 'property_004',
    landlordId: 'landlord_003',
    title: 'Riverside Residences',
    description: 'Modern boarding house with spacious rooms.',
    address: 'Libertad, Butuan City',
    latitude: 8.9458,
    longitude: 125.5334,
    imageUrls: [
      'https://images.unsplash.com/photo-1560185007-c5ca9d2c014d?w=800',
      'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
    ],
    amenities: [
      Amenity.wifi,
      Amenity.airConditioning,
      Amenity.parking,
      Amenity.cctv,
    ],
    genderPreference: GenderPreference.mixed,
    favoriteCount: 53,
    status: PropertyStatus.occupied,
  ),

  PropertyModel(
    id: 'property_005',
    landlordId: 'landlord_004',
    title: 'CSU Student Stay',
    description: 'Designed specifically for CSU students.',
    address: 'Ampayon, Butuan City',
    latitude: 8.9488,
    longitude: 125.5327,
    imageUrls: [
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
    ],
    amenities: [Amenity.wifi, Amenity.laundry, Amenity.studyArea],
    genderPreference: GenderPreference.female,
    favoriteCount: 65,
    status: PropertyStatus.available,
  ),

  PropertyModel(
    id: 'property_006',
    landlordId: 'landlord_004',
    title: 'Harmony Boarding Home',
    description: 'Peaceful and budget-friendly accommodation.',
    address: 'Ampayon, Butuan City',
    latitude: 8.9501,
    longitude: 125.5299,
    imageUrls: [
      'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800',
      'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800',
    ],
    amenities: [Amenity.wifi, Amenity.kitchen, Amenity.electricityIncluded],
    genderPreference: GenderPreference.mixed,
    favoriteCount: 12,
    status: PropertyStatus.occupied,
  ),
];
