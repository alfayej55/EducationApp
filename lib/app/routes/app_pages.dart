import 'package:get/get.dart';
import 'app_routes.dart';

import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/auth/signin/signin_view.dart';
import '../modules/auth/signin/signin_binding.dart';
import '../modules/auth/signup/signup_view.dart';
import '../modules/auth/signup/signup_binding.dart';
import '../modules/main/main_view.dart';
import '../modules/main/main_binding.dart';
import '../modules/saved_courses/saved_courses_view.dart';
import '../modules/payment/payment_view.dart';
import '../modules/notifications/notifications_view.dart';
import '../modules/settings/settings_view.dart';
import '../modules/edit_profile/edit_profile_binding.dart';
import '../modules/edit_profile/edit_profile_view.dart';
import '../modules/help/help_view.dart';
import '../modules/about/about_view.dart';
import '../modules/course_detail/course_detail_view.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.savedCourses,
      page: () => const SavedCoursesView(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentView(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.help,
      page: () => const HelpView(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutView(),
    ),
    GetPage(
      name: AppRoutes.courseDetail,
      page: () => const CourseDetailView(),
    ),
  ];
}
