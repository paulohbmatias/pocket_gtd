import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/list_tasks/widgets/delegate/delegate_bloc.dart';
import 'package:pocket_gtd/app/modules/list_tasks/list_tasks_module.dart';

void main() {

  initModule(ListTasksModule());
  DelegateBloc bloc;
  
  setUp(() {
      bloc = ListTasksModule.to.bloc<DelegateBloc>();
  });

  group('DelegateBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<DelegateBloc>());
    });
  });

}
  