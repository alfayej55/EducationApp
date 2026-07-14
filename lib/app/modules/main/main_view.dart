import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../home/home_view.dart';
import '../courses/courses_view.dart';
import '../search/search_view.dart';
import '../profile/profile_view.dart';
import 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeView(),
      const CoursesView(),
      const SearchView(),
      const ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: pages,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: controller.changePage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: AppStrings.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.play_circle_outline),
                  activeIcon: Icon(Icons.play_circle),
                  label: AppStrings.courses,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: AppStrings.search,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: AppStrings.profile,
                ),
              ],
            ),
          ),
        ));
  }
}
