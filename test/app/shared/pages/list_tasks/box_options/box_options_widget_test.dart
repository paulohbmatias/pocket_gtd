import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pocket_gtd/app/shared/pages/list_tasks/box_options/box_options_widget.dart';

main() {
  testWidgets('BoxOptionsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(BoxOptionsWidget()));
    final textFinder = find.text('BoxOptions');
    expect(textFinder, findsOneWidget);
  });
}
