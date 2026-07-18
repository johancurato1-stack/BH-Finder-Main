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
  parking,
  laundry,
  kitchen,
  airConditioning,
  studyArea,
  cctv,
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
