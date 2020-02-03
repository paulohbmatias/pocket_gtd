import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/register_routines/widgets/weeks/weeks_widget.dart';

main() {
  testWidgets('WeeksWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(WeeksWidget()));
    final textFinder = find.text('Weeks');
    expect(textFinder, findsOneWidget);
  });
}
