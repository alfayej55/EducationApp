import 'package:hive_flutter/hive_flutter.dart';
import 'hive_boxes.dart';

class HiveService {
  HiveService._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(HiveBoxes.users),
      Hive.openBox(HiveBoxes.session),
      Hive.openBox(HiveBoxes.settings),
    ]);

    _initialized = true;
  }
}
