import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/course_model.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/course_repository.dart';

class CoursesController extends GetxController {
  final CourseRepository _courseRepository = CourseRepository();

  final RxBool isLoading = false.obs;
  final RxList<CourseModel> courses = <CourseModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxString selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;

    categories.value = [
      CategoryModel(
        id: '0',
        name: 'All',
        icon: Icons.apps,
        color: AppColors.primary,
      ),
      ...SampleCategories.categories,
    ];
    courses.value = await _courseRepository.getPopularCourses();

    isLoading.value = false;
  }

  void selectCategory(String categoryName) {
    selectedCategory.value = categoryName;
  }

  List<CourseModel> get filteredCourses {
    if (selectedCategory.value == 'All') {
      return courses;
    }
    final categoryId = categories
        .firstWhere((c) => c.name == selectedCategory.value,
            orElse: () => categories.first)
        .id;
    return courses.where((c) => c.category == categoryId).toList();
  }
}
