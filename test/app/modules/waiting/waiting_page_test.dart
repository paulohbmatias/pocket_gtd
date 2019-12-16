import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/waiting/waiting_page.dart';

main() {
  testWidgets('WaitingPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(WaitingPage(title: 'Waiting')));
    final titleFinder = find.text('Waiting');
    expect(titleFinder, findsOneWidget);
  });
}
