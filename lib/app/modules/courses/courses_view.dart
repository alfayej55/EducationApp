import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/course_card.dart';
import 'courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(AppStrings.courses, style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }



        return Column(
          children: [
            // Category Filter
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  final isSelected =
                      controller.selectedCategory.value == category.name;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category.name),
                      selected: isSelected,
                      onSelected: (_) =>
                          controller.selectCategory(category.name),
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primary,
                      labelStyle: AppTextStyles.bodySmall.copyWith(
                        color:
                            isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Courses List
            Expanded(
              child: Obx(() {
                final filteredCourses = controller.filteredCourses;

                if (filteredCourses.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No courses found',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                  ),
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CourseCard(course: filteredCourses[index]),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
