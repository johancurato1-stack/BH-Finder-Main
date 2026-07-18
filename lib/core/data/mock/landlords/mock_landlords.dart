import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/landlord_model.dart';

//============================================================================
//! MOCK LANDLORDS
//============================================================================

const List<LandlordModel> mockLandlords = [
  LandlordModel(
    id: 'landlord_001',
    fullName: 'Juan Dela Cruz',
    phoneNumber: '09171234567',
    profileImageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    responseTime: ResponseTime.within30Minutes,
    verificationStatus: VerificationStatus.verified,
  ),

  LandlordModel(
    id: 'landlord_002',
    fullName: 'Maria Santos',
    phoneNumber: '09181234567',
    profileImageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    responseTime: ResponseTime.within1Hour,
    verificationStatus: VerificationStatus.verified,
  ),

  LandlordModel(
    id: 'landlord_003',
    fullName: 'Carlos Reyes',
    phoneNumber: '09191234567',
    profileImageUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
    responseTime: ResponseTime.within3Hours,
    verificationStatus: VerificationStatus.pending,
  ),

  LandlordModel(
    id: 'landlord_004',
    fullName: 'Angela Flores',
    phoneNumber: '09201234567',
    profileImageUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
    responseTime: ResponseTime.within15Minutes,
    verificationStatus: VerificationStatus.verified,
  ),

  LandlordModel(
    id: 'landlord_005',
    fullName: 'Mark Villanueva',
    phoneNumber: '09211234567',
    profileImageUrl:
        'https://images.unsplash.com/photo-1504593811423-6dd665756598',
    responseTime: ResponseTime.moreThan24Hours,
    verificationStatus: VerificationStatus.rejected,
  ),
];
