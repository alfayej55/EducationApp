import 'package:hive/hive.dart';
import '../hive_boxes.dart';

class SavedCoursesLocalService {
  Box get _settingsBox => Hive.box(HiveBoxes.settings);

  List<String> getSavedCourseIds() {
    final ids = _settingsBox.get(HiveKeys.savedCourseIds);
    if (ids is List) {
      return ids.map((id) => id.toString()).toList();
    }
    return [];
  }

  bool isSaved(String courseId) => getSavedCourseIds().contains(courseId);

  Future<void> toggleSaved(String courseId) async {
    final ids = getSavedCourseIds();
    if (ids.contains(courseId)) {
      ids.remove(courseId);
    } else {
      ids.add(courseId);
    }
    await _settingsBox.put(HiveKeys.savedCourseIds, ids);
  }

  Future<void> removeSaved(String courseId) async {
    final ids = getSavedCourseIds()..remove(courseId);
    await _settingsBox.put(HiveKeys.savedCourseIds, ids);
  }
}
