import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/routines/routines_bloc.dart';
import 'package:pocket_gtd/app/modules/routines/routines_module.dart';

void main() {
  initModule(RoutinesModule());
  RoutinesBloc bloc;

  setUp(() {
    bloc = RoutinesModule.to.bloc<RoutinesBloc>();
  });

  group('RoutinesBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<RoutinesBloc>());
    });
  });
}
