import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/auth/presentation/controllers/auth_gate_controller.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_category_section.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/presentation/providers/gallery_providers.dart';
import 'package:mobile/features/gallery/presentation/screens/gallery_tab_screen.dart';

void main() {
  testWidgets('empty gallery state does not overflow', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authGateBootstrapProvider.overrideWith((Ref ref) async {}),
          featuredTemplatesProvider.overrideWith(
            (Ref ref) => Stream.value(const <GalleryTemplate>[]),
          ),
          galleryCategorySectionsProvider.overrideWith(
            (Ref ref) => Stream.value(const <GalleryCategorySection>[]),
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: GalleryTabScreen())),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('No featured templates'), findsOneWidget);
    expect(find.text('Gallery is empty'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
