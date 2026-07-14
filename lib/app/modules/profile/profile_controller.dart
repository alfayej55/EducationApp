import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final RxString userName = 'Guest'.obs;
  final RxString userEmail = ''.obs;
  final RxInt completedCourses = 5.obs;
  final RxInt certificatesEarned = 3.obs;
  final RxInt hoursLearned = 48.obs;

  @override
  void onInit() {
    super.onInit();
    refreshUser();
  }

  void refreshUser() {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      userName.value = user.fullName;
      userEmail.value = user.email;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    Get.offAllNamed(AppRoutes.signIn);
  }
}
