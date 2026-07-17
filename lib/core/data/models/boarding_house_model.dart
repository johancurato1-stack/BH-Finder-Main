import 'package:flutter/material.dart';
import 'landlord_model.dart';

//============================================================================
//! VARIABLES
//============================================================================
class BoardingHouseModel extends ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String price;
  final String distanceText;
  final String genderRules;
  final String availabilityCount;
  final int totalRooms;
  final String status;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final String description;
  final Landlord landlord;
  final int availableRooms;
  final int reservedRooms;
  final int occupiedRooms;

  bool _isSaved;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================
  BoardingHouseModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.distanceText,
    required this.genderRules,
    required this.availabilityCount,
    required this.totalRooms,
    required this.status,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
    required this.description,
    required this.landlord,
    this.availableRooms = 0,
    this.reservedRooms = 0,
    this.occupiedRooms = 0,
    bool isSaved = false,
  }) : _isSaved = isSaved;

  bool get isSaved => _isSaved;

  set isSaved(bool value) {
    if (_isSaved != value) {
      _isSaved = value;
      notifyListeners();
    }
  }
}
