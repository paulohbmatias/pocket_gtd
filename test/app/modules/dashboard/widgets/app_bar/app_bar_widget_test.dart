import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pocket_gtd/app/modules/dashboard/widgets/app_bar/app_bar_widget.dart';

main() {
  testWidgets('AppBarWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(AppBarWidget()));
    final textFinder = find.text('AppBar');
    expect(textFinder, findsOneWidget);
  });
}
