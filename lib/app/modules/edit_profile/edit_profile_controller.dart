import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../local_database/services/auth_local_service.dart';
import '../home/home_controller.dart';
import '../profile/profile_controller.dart';

class EditProfileController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() {
    final user = _authRepository.getCurrentUser();
    if (user == null) return;

    nameController.text = user.fullName;
    emailController.text = user.email;
    phoneController.text = user.phone ?? '';
    bioController.text = user.bio ?? '';
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    isSaving.value = true;
    errorMessage.value = '';

    try {
      await _authRepository.updateProfile(
        fullName: nameController.text,
        email: emailController.text,
        bio: bioController.text,
        phone: phoneController.text,
      );

      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().refreshUser();
      }
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshUserName();
      }

      Get.back();
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
      );
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = 'Failed to update profile. Please try again.';
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
