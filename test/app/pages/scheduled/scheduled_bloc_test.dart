import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/pages/scheduled/scheduled_bloc.dart';
import 'package:pocket_gtd/app/pages/scheduled/scheduled_module.dart';

void main() {
  initModule(ScheduledModule());
  ScheduledBloc bloc;

  setUp(() {
    bloc = ScheduledModule.to.bloc<ScheduledBloc>();
  });

  group('ScheduledBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<ScheduledBloc>());
    });
  });
}
