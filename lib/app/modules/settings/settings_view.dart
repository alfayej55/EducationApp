import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';
import '../profile/profile_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _darkMode = false;
  bool _autoPlayVideos = true;
  bool _downloadOverWifi = true;
  String _videoQuality = 'Auto';
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.h3),
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
            // Account Settings
            _buildSectionHeader('Account'),
            _buildSettingsCard([
              _buildNavigationItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () => Get.toNamed(AppRoutes.editProfile),
              ),
              _buildNavigationItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () => _showChangePasswordDialog(),
              ),
              _buildNavigationItem(
                icon: Icons.security,
                title: 'Privacy Settings',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),

            // Notifications
            _buildSectionHeader('Notifications'),
            _buildSettingsCard([
              _buildSwitchItem(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                value: _pushNotifications,
                onChanged: (v) => setState(() => _pushNotifications = v),
              ),
              _buildSwitchItem(
                icon: Icons.email_outlined,
                title: 'Email Notifications',
                value: _emailNotifications,
                onChanged: (v) => setState(() => _emailNotifications = v),
              ),
            ]),
            const SizedBox(height: 24),

            // App Settings
            _buildSectionHeader('App Settings'),
            _buildSettingsCard([
              _buildSwitchItem(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
              _buildDropdownItem(
                icon: Icons.language,
                title: 'Language',
                value: _language,
                options: ['English', 'Spanish', 'French', 'German', 'Bengali'],
                onChanged: (v) => setState(() => _language = v!),
              ),
            ]),
            const SizedBox(height: 24),

            // Video Settings
            _buildSectionHeader('Video Settings'),
            _buildSettingsCard([
              _buildSwitchItem(
                icon: Icons.play_circle_outline,
                title: 'Auto-play Videos',
                value: _autoPlayVideos,
                onChanged: (v) => setState(() => _autoPlayVideos = v),
              ),
              _buildDropdownItem(
                icon: Icons.high_quality,
                title: 'Video Quality',
                value: _videoQuality,
                options: ['Auto', '1080p', '720p', '480p', '360p'],
                onChanged: (v) => setState(() => _videoQuality = v!),
              ),
              _buildSwitchItem(
                icon: Icons.wifi,
                title: 'Download over Wi-Fi only',
                value: _downloadOverWifi,
                onChanged: (v) => setState(() => _downloadOverWifi = v),
              ),
            ]),
            const SizedBox(height: 24),

            // Storage
            _buildSectionHeader('Storage'),
            _buildSettingsCard([
              _buildStorageItem(),
              _buildNavigationItem(
                icon: Icons.delete_outline,
                title: 'Clear Cache',
                subtitle: '256 MB',
                onTap: () => _showClearCacheDialog(),
                textColor: AppColors.error,
              ),
            ]),
            const SizedBox(height: 24),

            // Danger Zone
            _buildSectionHeader('Account Actions'),
            _buildSettingsCard([
              _buildNavigationItem(
                icon: Icons.logout,
                title: 'Sign Out',
                onTap: () => _showSignOutDialog(),
                textColor: AppColors.error,
              ),
              _buildNavigationItem(
                icon: Icons.delete_forever,
                title: 'Delete Account',
                onTap: () => _showDeleteAccountDialog(),
                textColor: AppColors.error,
              ),
            ]),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
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
        children: children,
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.textPrimary),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(color: textColor),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: AppTextStyles.caption)
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.primary,
        activeThumbColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildStorageItem() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage, color: AppColors.textPrimary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Storage Used', style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      '2.4 GB of 5 GB',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.48,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Current Password'),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Get.back(), child: const Text('Update')),
        ],
      ),
    );
  }

  void _showClearCacheDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear 256 MB of cached data. Continue?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Success', 'Cache cleared successfully');
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Get.back();
              if (Get.isRegistered<ProfileController>()) {
                await Get.find<ProfileController>().signOut();
              } else {
                await AuthRepository().signOut();
                Get.offAllNamed(AppRoutes.signIn);
              }
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Get.back();
              await AuthRepository().deleteAccount();
              Get.offAllNamed(AppRoutes.signIn);
              Get.snackbar(
                'Account Deleted',
                'Your account has been removed from this device',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
