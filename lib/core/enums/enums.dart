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
//! VERIFICATION STATUS
//============================================================================

enum VerificationStatus { notSubmitted, pending, approved, rejected }

//============================================================================
//! USER VERIFICATION STATUS
//============================================================================

enum UserVerificationStatus { verified, pending, unverified }

//============================================================================
//! MESSAGE TYPE
//============================================================================

enum MessageType { text, inquiry, system }

//============================================================================
//! MESSAGE STATUS
//============================================================================

enum MessageStatus { sending, sent, delivered, seen }

//============================================================================
//! INQUIRY STATUS
//============================================================================

enum InquiryStatus { pending, accepted, declined, expired }

//============================================================================
//! VALIDATION STATE
//============================================================================
enum ValidationState { neutral, valid, invalid }

//============================================================================
//! ADD PROPERTY VALIDATION RESULT
//============================================================================

enum AddPropertyValidationResult { success, photos, title, location, amenities }

//============================================================================
//! ADD ROOM VALIDATION RESULT
//============================================================================

enum AddRoomValidationResult {
  success,
  photos,
  title,
  price,
  capacity,
  description,
  gender,
}
