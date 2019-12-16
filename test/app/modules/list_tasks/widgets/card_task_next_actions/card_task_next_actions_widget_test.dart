import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_next_actions/card_task_next_actions_widget.dart';

main() {
  testWidgets('CardTaskNextActionsWidget has message',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(CardTaskNextActionsWidget()));
    final textFinder = find.text('CardTaskNextActions');
    expect(textFinder, findsOneWidget);
  });
}
