abstract class ProfileRepository {
  Future<Map<String, dynamic>?> getCurrentProfile();

  Future<int> getFavoritesCount();

  Future<int> getInquiriesCount();
}
