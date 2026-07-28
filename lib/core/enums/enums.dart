//============================================================================
//! GENDER PREFERENCE
//============================================================================

enum GenderPreference { male, female, mixed }

//============================================================================
//! PROPERTY STATUS
//============================================================================

enum PropertyStatus { available, occupied }

//============================================================================
//! AMENITIES
//============================================================================

enum Amenity {
  wifi,
  airConditioning,
  privateBathroom,
  kitchen,
  laundry,
  studyArea,
  desk,
  cabinet,
  cctv,
  security,
  parking,
  waterIncluded,
  electricityIncluded,
}

//============================================================================
//! RESPONSE TIME
//============================================================================

enum ResponseTime {
  within15Minutes,
  within30Minutes,
  within1Hour,
  within3Hours,
  within24Hours,
  moreThan24Hours,
}

//============================================================================
//! VERFICATION STATUS
//============================================================================

enum VerificationStatus { pending, verified, rejected }
