import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/list_tasks/widgets/card_task_next_actions/card_task_next_actions_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';

void main() {
  initModule(ListTasksModule());
  CardTaskNextActionsBloc bloc;

  setUp(() {
    bloc = ListTasksModule.to.bloc<CardTaskNextActionsBloc>();
  });

  group('CardTaskNextActionsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<CardTaskNextActionsBloc>());
    });
  });
}
