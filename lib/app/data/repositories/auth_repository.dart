import '../models/user_model.dart';
import '../../local_database/local_database.dart';

class AuthRepository {
  final AuthLocalService _authLocalService = AuthLocalService();

  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return _authLocalService.register(
      fullName: fullName,
      email: email,
      password: password,
    );
  }

  Future<UserModel> signIn(String email, String password) async {
    return _authLocalService.login(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _authLocalService.logout();
  }

  bool get isLoggedIn => _authLocalService.isLoggedIn;

  bool get isOnboardingCompleted => _authLocalService.isOnboardingCompleted;

  Future<void> completeOnboarding() async {
    await _authLocalService.setOnboardingCompleted();
  }

  Future<bool> validateSession() => _authLocalService.validateSession();

  UserModel? getCurrentUser() => _authLocalService.getCurrentUser();

  Future<UserModel> updateProfile({
    required String fullName,
    required String email,
    String? bio,
    String? phone,
  }) {
    return _authLocalService.updateProfile(
      fullName: fullName,
      email: email,
      bio: bio,
      phone: phone,
    );
  }

  Future<void> deleteAccount() => _authLocalService.deleteAccount();
}
