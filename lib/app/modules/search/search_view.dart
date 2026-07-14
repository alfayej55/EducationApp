import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/course_card.dart';
import 'search_controller.dart' as app;

class SearchView extends GetView<app.SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(AppStrings.search, style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
            ),
            child: TextField(
              controller: controller.searchTextController,
              onSubmitted: controller.search,
              decoration: InputDecoration(
                hintText: 'Search for courses...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                suffixIcon: Obx(() => controller.hasSearched.value
                    ? IconButton(
                        icon:
                            const Icon(Icons.close, color: AppColors.textHint),
                        onPressed: controller.clearSearch,
                      )
                    : const SizedBox.shrink()),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Content
          Expanded(
            child: Obx(() {
              // Loading State
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Search Results
              if (controller.hasSearched.value) {
                if (controller.searchResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No courses found',
                          style: AppTextStyles.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try searching with different keywords',
                          style: AppTextStyles.bodySmall.copyWith(
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
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CourseCard(course: controller.searchResults[index]),
                    );
                  },
                );
              }

              // Recent Searches (Initial State)
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recent Searches', style: AppTextStyles.h4),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.recentSearches.map((search) {
                        return ActionChip(
                          label: Text(search),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: AppColors.border),
                          labelStyle: AppTextStyles.bodySmall,
                          onPressed: () {
                            controller.searchTextController.text = search;
                            controller.search(search);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
