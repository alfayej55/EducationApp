import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // First Launch
  bool get isFirstLaunch => _prefs.getBool(AppConstants.keyIsFirstLaunch) ?? true;

  Future<void> setFirstLaunch(bool value) async {
    await _prefs.setBool(AppConstants.keyIsFirstLaunch, value);
  }

  // Login Status
  bool get isLoggedIn => _prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(AppConstants.keyIsLoggedIn, value);
  }

  // User Token
  String? get userToken => _prefs.getString(AppConstants.keyUserToken);

  Future<void> setUserToken(String? token) async {
    if (token != null) {
      await _prefs.setString(AppConstants.keyUserToken, token);
    } else {
      await _prefs.remove(AppConstants.keyUserToken);
    }
  }

  // User ID
  String? get userId => _prefs.getString(AppConstants.keyUserId);

  Future<void> setUserId(String? id) async {
    if (id != null) {
      await _prefs.setString(AppConstants.keyUserId, id);
    } else {
      await _prefs.remove(AppConstants.keyUserId);
    }
  }

  // Clear All
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
