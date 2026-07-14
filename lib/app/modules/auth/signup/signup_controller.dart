import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../local_database/services/auth_local_service.dart';
import '../../../routes/app_routes.dart';

class SignUpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool agreeToTerms = false.obs;
  final RxString errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.toggle();
  }

  void toggleAgreeToTerms() {
    agreeToTerms.toggle();
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    if (!agreeToTerms.value) {
      errorMessage.value = 'Please agree to the Terms & Conditions';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _authRepository.signUp(
        fullName: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAllNamed(AppRoutes.main);
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = 'Registration failed. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignIn() {
    Get.back();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
