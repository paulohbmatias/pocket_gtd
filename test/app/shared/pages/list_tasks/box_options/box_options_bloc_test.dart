import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/shared/pages/list_tasks/box_options/box_options_bloc.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/list_tasks_module.dart';

void main() {
  initModule(ListTasksModule());
  BoxOptionsBloc bloc;

  setUp(() {
    bloc = ListTasksModule.to.bloc<BoxOptionsBloc>();
  });

  group('BoxOptionsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<BoxOptionsBloc>());
    });
  });
}
