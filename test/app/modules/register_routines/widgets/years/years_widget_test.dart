import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/register_routines/widgets/years/years_widget.dart';

main() {
  testWidgets('YearsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(YearsWidget()));
    final textFinder = find.text('Years');
    expect(textFinder, findsOneWidget);
  });
}
