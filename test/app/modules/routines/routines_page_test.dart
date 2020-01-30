import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/routines/routines_page.dart';

main() {
  testWidgets('RoutinesPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(RoutinesPage(title: 'Routines')));
    final titleFinder = find.text('Routines');
    expect(titleFinder, findsOneWidget);
  });
}
