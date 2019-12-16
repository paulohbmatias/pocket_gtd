import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/projects/projects_page.dart';

main() {
  testWidgets('ProjectsPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(ProjectsPage(title: 'Projects')));
    final titleFinder = find.text('Projects');
    expect(titleFinder, findsOneWidget);
  });
}
