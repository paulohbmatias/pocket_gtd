import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pocket_gtd/app/modules/list_tasks/widgets/delegate/delegate_widget.dart';

main() {
  testWidgets('DelegateWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(DelegateWidget()));
    final textFinder = find.text('Delegate');
    expect(textFinder, findsOneWidget);
  });
}
  