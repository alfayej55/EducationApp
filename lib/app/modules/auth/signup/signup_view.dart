import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/validators.dart';
import '../../../widgets/custom_text_field.dart';
import 'signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(AppStrings.createAccount, style: AppTextStyles.h1),
                const SizedBox(height: 8),
                Text(
                  AppStrings.joinUs,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),

                // Full Name Field
                CustomTextField(
                  controller: controller.fullNameController,
                  label: AppStrings.fullName,
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 20),

                // Email Field
                CustomTextField(
                  controller: controller.emailController,
                  label: AppStrings.email,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 20),

                // Password Field
                Obx(() => CustomTextField(
                      controller: controller.passwordController,
                      label: AppStrings.password,
                      hint: 'Create a password',
                      isPassword: !controller.isPasswordVisible.value,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: controller.isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      onSuffixTap: controller.togglePasswordVisibility,
                      validator: Validators.validatePassword,
                    )),
                const SizedBox(height: 20),

                // Confirm Password Field
                Obx(() => CustomTextField(
                      controller: controller.confirmPasswordController,
                      label: AppStrings.confirmPassword,
                      hint: 'Confirm your password',
                      isPassword: !controller.isConfirmPasswordVisible.value,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: controller.isConfirmPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      onSuffixTap: controller.toggleConfirmPasswordVisibility,
                      validator: (value) => Validators.validateConfirmPassword(
                        value,
                        controller.passwordController.text,
                      ),
                    )),
                const SizedBox(height: 16),

                // Terms & Conditions Checkbox
                Obx(() => Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: controller.agreeToTerms.value,
                            onChanged: (_) => controller.toggleAgreeToTerms(),
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: controller.toggleAgreeToTerms,
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyles.bodySmall,
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 16),

                // Error Message
                Obx(() => controller.errorMessage.value.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: AppColors.error, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                controller.errorMessage.value,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink()),
                const SizedBox(height: 24),

                // Sign Up Button
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.signUp,
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(AppStrings.signUp),
                      ),
                    )),
                const SizedBox(height: 24),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: AppTextStyles.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: controller.goToSignIn,
                      child: Text(
                        AppStrings.signIn,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
