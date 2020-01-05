import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/one_day_maybe/one_day_maybe_page.dart';

main() {
  testWidgets('OneDayMaybePage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(OneDayMaybePage(title: 'OneDayMaybe')));
    final titleFinder = find.text('OneDayMaybe');
    expect(titleFinder, findsOneWidget);
  });
}
