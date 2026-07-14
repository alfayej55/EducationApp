import 'package:hive/hive.dart';
import '../../data/models/user_model.dart';
import '../hive_boxes.dart';
import '../models/registered_user_model.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthLocalService {
  Box get _usersBox => Hive.box(HiveBoxes.users);
  Box get _sessionBox => Hive.box(HiveBoxes.session);
  Box get _settingsBox => Hive.box(HiveBoxes.settings);

  String _normalizeEmail(String email) => email.trim().toLowerCase();

  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = _normalizeEmail(email);

    if (_usersBox.containsKey(normalizedEmail)) {
      throw AuthException('An account with this email already exists');
    }

    final user = RegisteredUserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName.trim(),
      email: normalizedEmail,
      password: password,
      createdAt: DateTime.now(),
    );

    await _usersBox.put(normalizedEmail, user.toMap());
    await _saveSession(normalizedEmail);

    return user.toUserModel();
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = _normalizeEmail(email);
    final data = _usersBox.get(normalizedEmail);

    if (data == null) {
      throw AuthException('No account found with this email');
    }

    final user = RegisteredUserModel.fromMap(
      Map<dynamic, dynamic>.from(data as Map),
    );

    if (user.password != password) {
      throw AuthException('Incorrect password');
    }

    await _saveSession(normalizedEmail);
    return user.toUserModel();
  }

  Future<void> logout() async {
    await _sessionBox.delete(HiveKeys.isLoggedIn);
    await _sessionBox.delete(HiveKeys.currentUserEmail);
  }

  bool get isLoggedIn =>
      _sessionBox.get(HiveKeys.isLoggedIn, defaultValue: false) == true;

  bool get isOnboardingCompleted =>
      _settingsBox.get(HiveKeys.onboardingCompleted, defaultValue: false) ==
      true;

  Future<void> setOnboardingCompleted() async {
    await _settingsBox.put(HiveKeys.onboardingCompleted, true);
  }

  UserModel? getCurrentUser() {
    if (!isLoggedIn) return null;

    final email = _sessionBox.get(HiveKeys.currentUserEmail) as String?;
    if (email == null) return null;

    final data = _usersBox.get(email);
    if (data == null) return null;

    return RegisteredUserModel.fromMap(
      Map<dynamic, dynamic>.from(data as Map),
    ).toUserModel();
  }

  Future<bool> validateSession() async {
    if (!isLoggedIn) return false;
    if (getCurrentUser() != null) return true;
    await logout();
    return false;
  }

  Future<UserModel> updateProfile({
    required String fullName,
    required String email,
    String? bio,
    String? phone,
  }) async {
    final currentEmail = _sessionBox.get(HiveKeys.currentUserEmail) as String?;
    if (currentEmail == null) {
      throw AuthException('No active session found');
    }

    final data = _usersBox.get(currentEmail);
    if (data == null) {
      throw AuthException('User account not found');
    }

    final user = RegisteredUserModel.fromMap(
      Map<dynamic, dynamic>.from(data as Map),
    );

    final normalizedEmail = _normalizeEmail(email);
    if (normalizedEmail != currentEmail &&
        _usersBox.containsKey(normalizedEmail)) {
      throw AuthException('An account with this email already exists');
    }

    final updatedUser = user.copyWith(
      fullName: fullName.trim(),
      email: normalizedEmail,
      bio: bio?.trim(),
      phone: phone?.trim(),
    );

    if (normalizedEmail != currentEmail) {
      await _usersBox.delete(currentEmail);
    }
    await _usersBox.put(normalizedEmail, updatedUser.toMap());
    await _saveSession(normalizedEmail);

    return updatedUser.toUserModel();
  }

  Future<void> deleteAccount() async {
    final email = _sessionBox.get(HiveKeys.currentUserEmail) as String?;
    if (email != null) {
      await _usersBox.delete(email);
    }
    await logout();
  }

  List<RegisteredUserModel> getAllRegisteredUsers() {
    return _usersBox.values
        .map(
          (data) => RegisteredUserModel.fromMap(
            Map<dynamic, dynamic>.from(data as Map),
          ),
        )
        .toList();
  }

  Future<void> _saveSession(String email) async {
    await _sessionBox.put(HiveKeys.isLoggedIn, true);
    await _sessionBox.put(HiveKeys.currentUserEmail, email);
  }
}
