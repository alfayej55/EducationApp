import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/course_card.dart';
import '../../widgets/category_card.dart';
import '../../widgets/continue_learning_card.dart';
import '../../routes/app_routes.dart';
import '../main/main_controller.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: controller.refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  const SizedBox(height: 24),

                  // Search Bar
                  _buildSearchBar(),
                  const SizedBox(height: 24),

                  // Continue Learning Section
                  if (controller.enrolledCourses.isNotEmpty) ...[
                    _buildSectionHeader(AppStrings.continueLearning),
                    const SizedBox(height: 16),
                    _buildContinueLearning(),
                    const SizedBox(height: 24),
                  ],

                  // Categories Section
                  _buildSectionHeader(AppStrings.categories),
                  const SizedBox(height: 16),
                  _buildCategories(),
                  const SizedBox(height: 24),

                  // Popular Courses Section
                  _buildSectionHeader(
                    AppStrings.popularCourses,
                    onSeeAll: () => Get.find<MainController>().changePage(1),
                  ),
                  const SizedBox(height: 16),
                  _buildPopularCourses(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppStrings.hello}, ${controller.userName.value}!',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.whatToLearn,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.notifications),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildSearchBar() {

    return GestureDetector(
      onTap: () {

        // Navigate to search or trigger search focus
        final mainController = Get.find<MainController>();
        mainController.changePage(2);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),

        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textHint),
            const SizedBox(width: 12),
            Text(
              'Search for courses...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],



        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.h4),
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            AppStrings.seeAll,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueLearning() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.enrolledCourses.length,
        itemBuilder: (context, index) {
          final course = controller.enrolledCourses[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index < controller.enrolledCourses.length - 1 ? 16 : 0,
            ),
            child: ContinueLearningCard(course: course),
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index < controller.categories.length - 1 ? 12 : 0,
            ),
            child: CategoryCard(category: category),
          );
        },
      ),
    );
  }

  Widget _buildPopularCourses() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.popularCourses.length,
      itemBuilder: (context, index) {
        final course = controller.popularCourses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CourseCard(course: course),
        );
      },
    );
  }
}
