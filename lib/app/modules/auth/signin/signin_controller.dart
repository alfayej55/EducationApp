import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../local_database/services/auth_local_service.dart';
import '../../../routes/app_routes.dart';

class SignInController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxString errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _authRepository.signIn(
        emailController.text,
        passwordController.text,
      );
      Get.offAllNamed(AppRoutes.main);
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = 'Sign in failed. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  void goToForgotPassword() {
    Get.snackbar(
      'Coming Soon',
      'Forgot password feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
