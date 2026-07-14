import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_assets.dart';
import '../../widgets/app_image.dart';
import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    AppStrings.skip,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            // Page View
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  OnboardingPage(
                    imagePath: AppAssets.bookOnboarding1,
                    title: AppStrings.onboardingTitle1,
                    description: AppStrings.onboardingDesc1,
                    color: AppColors.primary,
                  ),
                  OnboardingPage(
                    imagePath: AppAssets.bookOnboarding2,
                    title: AppStrings.onboardingTitle2,
                    description: AppStrings.onboardingDesc2,
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ),

            // Bottom Section
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                children: [
                  // Page Indicator
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.totalPages,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.border,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Next/Get Started Button
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: controller.nextPage,
                          child: Text(
                            controller.currentPage.value ==
                                    controller.totalPages - 1
                                ? AppStrings.getStarted
                                : AppStrings.next,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Color color;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 280,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AppImage(
                imagePath: imagePath,
                width: 200,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Title
          Text(
            title,
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
