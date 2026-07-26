import 'package:bh_finder/core/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    throw UnimplementedError('Mock signUp() has not been implemented.');
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    throw UnimplementedError('Mock signIn() has not been implemented.');
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError('Mock signOut() has not been implemented.');
  }

  @override
  Future<void> resetPassword({required String email}) async {
    throw UnimplementedError('Mock resetPassword() has not been implemented.');
  }

  @override
  bool get isLoggedIn => false;

  @override
  String? get currentUserId => null;
}
