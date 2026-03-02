import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart' as app;

void main() {
  testWidgets('app boots', (WidgetTester tester) async {
    await app.main();
  });
}
