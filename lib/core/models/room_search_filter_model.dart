//============================================================================
//! ROOM SEARCH FILTER MODEL
//============================================================================

class RoomSearchFilterModel {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomSearchFilterModel({this.sortPrice = 'Any', this.gender = 'Any'});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String sortPrice;

  final String gender;

  //============================================================================
  //! COPY WITH
  //============================================================================

  RoomSearchFilterModel copyWith({String? sortPrice, String? gender}) {
    return RoomSearchFilterModel(
      sortPrice: sortPrice ?? this.sortPrice,
      gender: gender ?? this.gender,
    );
  }
}
