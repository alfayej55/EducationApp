import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final int totalPages = 2;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skip() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    await _authRepository.completeOnboarding();
    Get.offAllNamed(AppRoutes.signIn);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
