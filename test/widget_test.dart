import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:online_education/app/local_database/hive_boxes.dart';
import 'package:online_education/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Hive.init('test_hive_data');
    await Future.wait([
      Hive.openBox(HiveBoxes.users),
      Hive.openBox(HiveBoxes.session),
      Hive.openBox(HiveBoxes.settings),
    ]);
  });

  testWidgets('App loads splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('EduSkill'), findsOneWidget);
    expect(find.text('Learn. Grow. Succeed.'), findsOneWidget);
  });
}
