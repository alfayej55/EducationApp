import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/app_colors.dart';
import 'app_image.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/course_model.dart';
import '../routes/app_routes.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.toNamed(AppRoutes.courseDetail, arguments: course),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  AppImage(
                    imagePath: course.thumbnail,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Price Tag
                  Positioned(

                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),


                      decoration: BoxDecoration(
                        color: course.isFree
                            ? AppColors.success
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        course.isFree ? 'FREE' : '\$${course.price}',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    course.title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Instructor
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        course.instructorName,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Stats Row
                  Row(
                    children: [
                      _buildStatChip(
                        Icons.star,
                        course.rating.toString(),
                        AppColors.warning,
                      ),
                      const SizedBox(width: 12),
                      _buildStatChip(
                        Icons.play_circle_outline,
                        '${course.totalLessons} lessons',
                        AppColors.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      _buildStatChip(
                        Icons.timer_outlined,
                        '${course.totalHours}h',
                        AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: color == AppColors.warning ? color : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
