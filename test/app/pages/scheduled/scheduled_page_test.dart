import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/pages/scheduled/scheduled_page.dart';

main() {
  testWidgets('ScheduledPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(ScheduledPage(title: 'Scheduled')));
    final titleFinder = find.text('Scheduled');
    expect(titleFinder, findsOneWidget);
  });
}
