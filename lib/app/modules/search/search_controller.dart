import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/repositories/course_repository.dart';

class SearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final CourseRepository _courseRepository = CourseRepository();

  final RxBool isLoading = false.obs;
  final RxList<CourseModel> searchResults = <CourseModel>[].obs;
  final RxBool hasSearched = false.obs;

  final List<String> recentSearches = [
    'Flutter Development',
    'UI/UX Design',
    'Python',
    'Machine Learning',
  ];

  Future<void> search(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      hasSearched.value = false;
      return;
    }

    isLoading.value = true;
    hasSearched.value = true;

    searchResults.value = await _courseRepository.searchCourses(query);

    isLoading.value = false;
  }

  void clearSearch() {
    searchTextController.clear();
    searchResults.clear();
    hasSearched.value = false;
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
