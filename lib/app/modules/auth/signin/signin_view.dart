import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/validators.dart';
import '../../../widgets/custom_text_field.dart';
import 'signin_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Header
                Text(AppStrings.welcomeBack, style: AppTextStyles.h1),
                const SizedBox(height: 8),
                Text(
                  AppStrings.signInToContinue,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),

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
                      hint: 'Enter your password',
                      isPassword: !controller.isPasswordVisible.value,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: controller.isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      onSuffixTap: controller.togglePasswordVisibility,
                      validator: Validators.validatePassword,
                    )),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.goToForgotPassword,
                    child: Text(
                      AppStrings.forgotPassword,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

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

                // Sign In Button
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.signIn,
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(AppStrings.signIn),
                      ),
                    )),
                const SizedBox(height: 32),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: AppTextStyles.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: controller.goToSignUp,
                      child: Text(
                        AppStrings.signUp,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
