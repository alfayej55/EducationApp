import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_assets.dart';
import '../../core/utils/validators.dart';
import '../../widgets/app_image.dart';
import 'edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('Edit Profile', style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: controller.isSaving.value ? null : controller.saveProfile,
              child: controller.isSaving.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      'Save',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Center(
                child: ClipOval(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 3),
                      shape: BoxShape.circle,
                    ),
                    child: const AppImage(
                      imagePath: AppAssets.bookInstructor,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Full Name',
                      controller: controller.nameController,
                      icon: Icons.person_outline,
                      validator: Validators.validateName,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'Email',
                      controller: controller.emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'Phone Number',
                      controller: controller.phoneController,
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'Bio',
                      controller: controller.bioController,
                      icon: Icons.info_outline,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => controller.errorMessage.value.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.errorMessage.value,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textHint),
            filled: true,
            fillColor: AppColors.scaffoldBackground,
          ),
        ),
      ],
    );
  }
}
