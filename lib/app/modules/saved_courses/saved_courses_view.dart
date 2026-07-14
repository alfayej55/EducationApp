import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/course_card.dart';
import '../../data/models/course_model.dart';
import '../../data/repositories/course_repository.dart';
import '../../local_database/services/saved_courses_local_service.dart';

class SavedCoursesView extends StatefulWidget {
  const SavedCoursesView({super.key});

  @override
  State<SavedCoursesView> createState() => _SavedCoursesViewState();
}

class _SavedCoursesViewState extends State<SavedCoursesView> {
  final SavedCoursesLocalService _savedCoursesService =
      SavedCoursesLocalService();

  List<CourseModel> get _savedCourses {
    final ids = _savedCoursesService.getSavedCourseIds();
    return CourseRepository.mockCourses
        .where((course) => ids.contains(course.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final savedCourses = _savedCourses;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('Saved Courses', style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: savedCourses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: savedCourses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Dismissible(
                    key: Key(savedCourses[index].id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) async {
                      await _savedCoursesService.removeSaved(
                        savedCourses[index].id,
                      );
                      setState(() {});
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    child: CourseCard(course: savedCourses[index]),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bookmark_outline,
              size: 50,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text('No Saved Courses', style: AppTextStyles.h4),
          const SizedBox(height: 8),
          Text(
            'Courses you save will appear here',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Browse Courses'),
          ),
        ],
      ),
    );
  }
}
