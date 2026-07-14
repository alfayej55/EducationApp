import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_assets.dart';
import '../../widgets/app_image.dart';
import '../../routes/app_routes.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
        ],

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          children: [
            // Profile
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // Stats Section
            _buildStatsSection(),
            const SizedBox(height: 24),

            // Menu Items
            _buildMenuSection(),
          ],
        ),
      ),
    );
  }
     

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
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

      child: Row(
        children: [
          ClipOval(
            child: AppImage(
              imagePath: AppAssets.bookInstructor,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(controller.userName.value, style: AppTextStyles.h4)),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    controller.userEmail.value,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Premium Member',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            onPressed: () => Get.toNamed(AppRoutes.editProfile),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(20),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              Icons.school_outlined,
              controller.completedCourses.value.toString(),
              'Courses',
              AppColors.primary,
            ),
            _buildStatItem(
              Icons.workspace_premium_outlined,
              controller.certificatesEarned.value.toString(),
              'Certificates',
              AppColors.secondary,
            ),
            _buildStatItem(
              Icons.timer_outlined,
              '${controller.hoursLearned.value}h',
              'Learning',
              AppColors.success,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.h4),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Container(
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
        children: [
          _buildMenuItem(
            Icons.bookmark_outline,
            'Saved Courses',
            onTap: () => Get.toNamed(AppRoutes.savedCourses),
          ),
          _buildDivider(),
          _buildMenuItem(
            Icons.payment_outlined,
            'Payment Methods',
            onTap: () => Get.toNamed(AppRoutes.payment),
          ),
          _buildDivider(),
          _buildMenuItem(
            Icons.notifications_outlined,
            'Notifications',
            onTap: () => Get.toNamed(AppRoutes.notifications),
            badge: '3',
          ),
          _buildDivider(),
          _buildMenuItem(
            Icons.language_outlined,
            'Language',
            trailing: 'English',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            Icons.help_outline,
            'Help & Support',
            onTap: () => Get.toNamed(AppRoutes.help),
          ),
          _buildDivider(),
          _buildMenuItem(
            Icons.info_outline,
            'About',
            onTap: () => Get.toNamed(AppRoutes.about),
          ),
          _buildDivider(),
          _buildMenuItem(
            Icons.logout,
            'Sign Out',
            textColor: AppColors.error,
            onTap: () => _showSignOutDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? trailing,
    String? badge,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.textPrimary),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(color: textColor),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: AppTextStyles.caption.copyWith(color: Colors.white),
              ),
            )
          : trailing != null
              ? Text(
                  trailing,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                )
              : const Icon(Icons.chevron_right, color: AppColors.textHint),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: AppColors.divider);
  }

  void _showSignOutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.signOut();
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
