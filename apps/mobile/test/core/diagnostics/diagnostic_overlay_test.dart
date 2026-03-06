import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/diagnostics/diagnostic_overlay.dart';
import 'package:mobile/core/diagnostics/diagnostics_screen.dart';
import 'package:mobile/core/routing/app_router.dart';

void main() {
  group('DiagnosticOverlay', () {
    testWidgets('tapping bug FAB opens diagnostics screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(withRootNavigatorKey: true));

      expect(find.byType(DiagnosticsScreen), findsNothing);

      await tester.tap(find.byIcon(Icons.bug_report));
      await tester.pumpAndSettle();

      expect(find.byType(DiagnosticsScreen), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('tapping bug FAB without root navigator does not throw', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(withRootNavigatorKey: false));

      await tester.tap(find.byIcon(Icons.bug_report));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.byType(DiagnosticsScreen), findsNothing);
    });
  });
}

Widget _buildTestApp({required bool withRootNavigatorKey}) {
  return MaterialApp(
    navigatorKey: withRootNavigatorKey ? rootNavigatorKey : null,
    home: const Scaffold(body: SizedBox.expand()),
    builder: (BuildContext context, Widget? child) {
      return DiagnosticOverlay(child: child ?? const SizedBox.shrink());
    },
  );
}
