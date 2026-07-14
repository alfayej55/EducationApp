import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('Help & Support', style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Help
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for help...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                  border: InputBorder.none,
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Text('Quick Actions', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildQuickAction(
                  icon: Icons.chat_bubble_outline,
                  label: 'Live Chat',
                  color: AppColors.primary,
                  onTap: () => _showLiveChat(),
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Icons.email_outlined,
                  label: 'Email Us',
                  color: AppColors.secondary,
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Icons.phone_outlined,
                  label: 'Call Us',
                  color: AppColors.success,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),

            // FAQs
            Text('Frequently Asked Questions', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            _buildFAQItem(
              question: 'How do I enroll in a course?',
              answer:
                  'To enroll in a course, browse our course catalog, select the course you want, and click the "Enroll Now" button. You can pay using any of our supported payment methods.',
            ),
            _buildFAQItem(
              question: 'Can I download courses for offline viewing?',
              answer:
                  'Yes! Premium members can download course videos for offline viewing. Look for the download icon on each lesson.',
            ),
            _buildFAQItem(
              question: 'How do I get a certificate?',
              answer:
                  'Complete all lessons and pass the final assessment with at least 70% score. Your certificate will be automatically generated and available in your profile.',
            ),
            _buildFAQItem(
              question: 'What is the refund policy?',
              answer:
                  'We offer a 30-day money-back guarantee on all courses. If you\'re not satisfied, contact support for a full refund.',
            ),
            _buildFAQItem(
              question: 'How do I reset my password?',
              answer:
                  'Go to Settings > Change Password, or use the "Forgot Password" link on the sign-in page to reset your password via email.',
            ),
            const SizedBox(height: 32),

            // Contact Information
            Text('Contact Information', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
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
                  _buildContactItem(
                    icon: Icons.email,
                    title: 'Email',
                    value: 'support@eduskill.com',
                  ),
                  const Divider(height: 24),
                  _buildContactItem(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: '+1 (800) 123-4567',
                  ),
                  const Divider(height: 24),
                  _buildContactItem(
                    icon: Icons.access_time,
                    title: 'Working Hours',
                    value: 'Mon - Fri, 9AM - 6PM EST',
                  ),
                  const Divider(height: 24),
                  _buildContactItem(
                    icon: Icons.location_on,
                    title: 'Address',
                    value: '123 Education St, New York, NY 10001',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Report a Problem
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.bug_report, color: AppColors.error, size: 40),
                  const SizedBox(height: 12),
                  Text('Found a bug?', style: AppTextStyles.h4),
                  const SizedBox(height: 8),
                  Text(
                    'Help us improve by reporting issues',
                    style: AppTextStyles.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    child: const Text('Report Issue'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.caption),
              Text(value, style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  void _showLiveChat() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text('Live Chat', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            Text(
              'Our support team typically replies within 5 minutes',
              style: AppTextStyles.bodySmall,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
