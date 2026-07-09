enum VerificationStatus { verified, pending, unverified }

class UserModel {
  final String name;
  final String email;
  final String avatarUrl;
  final VerificationStatus verificationStatus;
  final int favoritesCount;
  final int recentlyViewedCount;
  final int inquiriesCount;

  const UserModel({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.verificationStatus,
    required this.favoritesCount,
    required this.recentlyViewedCount,
    required this.inquiriesCount,
  });
}

const mockUser = UserModel(
  name: 'Johan Garcia Curato',
  email: 'johancurato1@gmail.com',
  avatarUrl: '',
  verificationStatus: VerificationStatus.verified,
  favoritesCount: 0,
  recentlyViewedCount: 0,
  inquiriesCount: 2,
);
