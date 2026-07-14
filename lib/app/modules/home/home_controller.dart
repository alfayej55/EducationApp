import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/course_repository.dart';

class HomeController extends GetxController {
  final CourseRepository _courseRepository = CourseRepository();
  final AuthRepository _authRepository = AuthRepository();

  final RxBool isLoading = false.obs;
  final RxList<CourseModel> popularCourses = <CourseModel>[].obs;
  final RxList<CourseModel> enrolledCourses = <CourseModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxString userName = 'Guest'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
    loadData();
  }

  void _loadUserName() {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      userName.value = user.fullName.split(' ').first;
    }
  }

  void refreshUserName() {
    _loadUserName();
  }

  Future<void> loadData() async {
    isLoading.value = true;

    categories.value = SampleCategories.categories;
    popularCourses.value = await _courseRepository.getPopularCourses();
    enrolledCourses.value = await _courseRepository.getEnrolledCourses();

    isLoading.value = false;
  }

  Future<void> refreshData() async {
    await loadData();
  }
}
