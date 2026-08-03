//============================================================================
//! ROOM SEARCH FILTER MODEL
//============================================================================

class RoomSearchFilterModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String sortPrice;

  final String gender;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomSearchFilterModel({this.sortPrice = 'Any', this.gender = 'Any'});

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
