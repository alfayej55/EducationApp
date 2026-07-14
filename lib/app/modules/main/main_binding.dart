import 'package:get/get.dart';
import 'main_controller.dart';
import '../home/home_controller.dart';
import '../courses/courses_controller.dart';
import '../search/search_controller.dart' as app;
import '../profile/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CoursesController>(() => CoursesController());
    Get.lazyPut<app.SearchController>(() => app.SearchController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
