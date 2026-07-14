import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('About', style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // App Logo & Info
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.school_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(AppConstants.appName, style: AppTextStyles.h2),
            const SizedBox(height: 4),
            Text(
              'Version ${AppConstants.appVersion}',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 32),

            // Mission Statement
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLarge,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Empowering learners worldwide with accessible, high-quality education for skill development and career growth.',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.white,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
              ),
              child: Row(
                children: [
                  _buildStatCard('10M+', 'Learners', Icons.people),
                  const SizedBox(width: 12),
                  _buildStatCard('5K+', 'Courses', Icons.play_circle),
                  const SizedBox(width: 12),
                  _buildStatCard('500+', 'Instructors', Icons.school),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
              ),
              child: Container(
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
                  children: [
                    _buildMenuItem(
                      icon: Icons.description_outlined,
                      title: 'Terms of Service',
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    _buildMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    _buildMenuItem(
                      icon: Icons.security_outlined,
                      title: 'Security',
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    _buildMenuItem(
                      icon: Icons.copyright_outlined,
                      title: 'Licenses',
                      onTap: () => _showLicenses(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Social Links
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
              ),
              child: Column(
                children: [
                  Text('Follow Us', style: AppTextStyles.h4),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(Icons.facebook, const Color(0xFF1877F2)),
                      const SizedBox(width: 16),
                      _buildSocialButton(Icons.camera_alt, const Color(0xFFE4405F)),
                      const SizedBox(width: 16),
                      _buildSocialButton(Icons.alternate_email, const Color(0xFF1DA1F2)),
                      const SizedBox(width: 16),
                      _buildSocialButton(Icons.play_arrow, const Color(0xFFFF0000)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // App Rating
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: AppColors.warning,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Enjoying EduSkill?', style: AppTextStyles.h4),
                    const SizedBox(height: 8),
                    Text(
                      'Rate us on the App Store',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Rate Now'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Copyright
            Text(
              '© 2024 EduSkill. All rights reserved.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 8),
            Text(
              'Made with ❤️ for learners',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTextStyles.h3.copyWith(color: AppColors.primary),
            ),
            Text(label, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
      onTap: onTap,
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {},
      ),
    );
  }

  void _showLicenses() {
    Get.to(
      () => const LicensePage(
        applicationName: AppConstants.appName,
        applicationVersion: AppConstants.appVersion,
        applicationIcon: Padding(
          padding: EdgeInsets.all(16),
          child: Icon(Icons.school_rounded, size: 48, color: AppColors.primary),
        ),
      ),
    );
  }
}
