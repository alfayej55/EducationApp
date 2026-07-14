import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onReady() {
    super.onReady();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      if (await _authRepository.validateSession()) {
        Get.offAllNamed(AppRoutes.main);
        return;
      }

      if (!_authRepository.isOnboardingCompleted) {
        Get.offAllNamed(AppRoutes.onboarding);
        return;
      }

      Get.offAllNamed(AppRoutes.signIn);
    } catch (_) {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
