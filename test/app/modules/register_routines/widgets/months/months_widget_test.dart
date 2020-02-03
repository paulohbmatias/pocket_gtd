import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/register_routines/widgets/months/months_widget.dart';

main() {
  testWidgets('MonthsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MonthsWidget()));
    final textFinder = find.text('Months');
    expect(textFinder, findsOneWidget);
  });
}
