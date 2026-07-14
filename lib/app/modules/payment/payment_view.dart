import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/auth_repository.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthRepository().getCurrentUser();
    final cardHolder = user?.fullName ?? 'Guest User';
    final payPalEmail = user?.email ?? 'Not connected';

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text('Payment Methods', style: AppTextStyles.h3),
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
            Text('Saved Cards', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            _buildPaymentCard(
              cardNumber: '**** **** **** 4242',
              cardHolder: cardHolder,
              expiry: '12/25',
              cardType: 'visa',
              isDefault: true,
            ),
            const SizedBox(height: 12),
            _buildPaymentCard(
              cardNumber: '**** **** **** 5555',
              cardHolder: cardHolder,
              expiry: '08/26',
              cardType: 'mastercard',
              isDefault: false,
            ),
            const SizedBox(height: 24),
            _buildAddCardButton(),
            const SizedBox(height: 32),
            Text('Other Payment Methods', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            _buildPaymentMethod(
              icon: Icons.account_balance_wallet,
              title: 'PayPal',
              subtitle: payPalEmail,
              color: const Color(0xFF003087),
            ),
            const SizedBox(height: 12),
            _buildPaymentMethod(
              icon: Icons.phone_android,
              title: 'Google Pay',
              subtitle: 'Connected',
              color: const Color(0xFF4285F4),
            ),
            const SizedBox(height: 12),
            _buildPaymentMethod(
              icon: Icons.apple,
              title: 'Apple Pay',
              subtitle: 'Not Connected',
              color: Colors.black,
              isConnected: false,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: AppTextStyles.h4),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            const SizedBox(height: 16),
            _buildTransactionItem(
              title: 'Flutter Development Masterclass',
              date: 'Jul 10, 2026',
              amount: '-\$49.99',
              icon: Icons.school_outlined,
            ),
            _buildTransactionItem(
              title: 'UI/UX Design Fundamentals',
              date: 'Jul 5, 2026',
              amount: '-\$39.99',
              icon: Icons.design_services_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard({
    required String cardNumber,
    required String cardHolder,
    required String expiry,
    required String cardType,
    required bool isDefault,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cardType == 'visa'
              ? [const Color(0xFF1A1F71), const Color(0xFF00579F)]
              : [const Color(0xFFEB001B), const Color(0xFFF79E1B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardType.toUpperCase(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isDefault)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Default',
                    style: AppTextStyles.caption.copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            cardNumber,
            style: AppTextStyles.h4.copyWith(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARD HOLDER',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    cardHolder,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXPIRES',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    expiry,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add),
      label: const Text('Add New Card'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    bool isConnected = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          Text(
            isConnected ? 'Connected' : 'Connect',
            style: AppTextStyles.caption.copyWith(
              color: isConnected ? AppColors.success : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                Text(date, style: AppTextStyles.caption),
              ],
            ),
          ),
          Text(
            amount,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
