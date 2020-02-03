import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/register_routines/widgets/days/days_widget.dart';

main() {
  testWidgets('DaysWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(DaysWidget()));
    final textFinder = find.text('Days');
    expect(textFinder, findsOneWidget);
  });
}
