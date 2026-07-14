import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('Notifications', style: AppTextStyles.h3),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all read',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                padding: const EdgeInsets.all(4),
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Courses'),
                  Tab(text: 'Promos'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  _buildAllNotifications(),
                  _buildCourseNotifications(),
                  _buildPromoNotifications(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllNotifications() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      children: [
        _buildDateHeader('Today'),
        _buildNotificationItem(
          icon: Icons.play_circle,
          iconColor: AppColors.primary,
          title: 'New lesson available',
          subtitle: 'Flutter Masterclass - Chapter 15 is now available',
          time: '2 hours ago',
          isUnread: true,
        ),
        _buildNotificationItem(
          icon: Icons.emoji_events,
          iconColor: AppColors.warning,
          title: 'Achievement Unlocked!',
          subtitle: 'You completed 5 courses this month',
          time: '5 hours ago',
          isUnread: true,
        ),
        _buildDateHeader('Yesterday'),
        _buildNotificationItem(
          icon: Icons.local_offer,
          iconColor: AppColors.secondary,
          title: '50% Off on Premium Courses',
          subtitle: 'Limited time offer on selected courses',
          time: '1 day ago',
          isUnread: false,
        ),
        _buildNotificationItem(
          icon: Icons.comment,
          iconColor: AppColors.info,
          title: 'Instructor replied',
          subtitle: 'John Doe replied to your question',
          time: '1 day ago',
          isUnread: false,
        ),
        _buildDateHeader('This Week'),
        _buildNotificationItem(
          icon: Icons.star,
          iconColor: AppColors.warning,
          title: 'Rate your experience',
          subtitle: 'How was UI/UX Design course?',
          time: '3 days ago',
          isUnread: false,
        ),
        _buildNotificationItem(
          icon: Icons.workspace_premium,
          iconColor: AppColors.success,
          title: 'Certificate Ready',
          subtitle: 'Download your Python Basics certificate',
          time: '5 days ago',
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildCourseNotifications() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      children: [
        _buildNotificationItem(
          icon: Icons.play_circle,
          iconColor: AppColors.primary,
          title: 'New lesson available',
          subtitle: 'Flutter Masterclass - Chapter 15 is now available',
          time: '2 hours ago',
          isUnread: true,
        ),
        _buildNotificationItem(
          icon: Icons.comment,
          iconColor: AppColors.info,
          title: 'Instructor replied',
          subtitle: 'John Doe replied to your question',
          time: '1 day ago',
          isUnread: false,
        ),
        _buildNotificationItem(
          icon: Icons.workspace_premium,
          iconColor: AppColors.success,
          title: 'Certificate Ready',
          subtitle: 'Download your Python Basics certificate',
          time: '5 days ago',
          isUnread: false,
        ),
        _buildNotificationItem(
          icon: Icons.update,
          iconColor: AppColors.primary,
          title: 'Course Updated',
          subtitle: 'UI/UX Design course has new content',
          time: '1 week ago',
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildPromoNotifications() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      children: [
        _buildNotificationItem(
          icon: Icons.local_offer,
          iconColor: AppColors.secondary,
          title: '50% Off on Premium Courses',
          subtitle: 'Limited time offer on selected courses',
          time: '1 day ago',
          isUnread: true,
        ),
        _buildNotificationItem(
          icon: Icons.card_giftcard,
          iconColor: AppColors.success,
          title: 'Free Course Friday!',
          subtitle: 'Get one free course every Friday',
          time: '4 days ago',
          isUnread: false,
        ),
        _buildNotificationItem(
          icon: Icons.celebration,
          iconColor: AppColors.warning,
          title: 'Holiday Sale - 70% Off',
          subtitle: 'Biggest sale of the year!',
          time: '1 week ago',
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        date,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.primary.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isUnread
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.2))
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
