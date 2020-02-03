import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/register_routines/widgets/months/months_bloc.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';

void main() {
  initModule(RegisterRoutinesModule());
  MonthsBloc bloc;

  setUp(() {
    bloc = RegisterRoutinesModule.to.bloc<MonthsBloc>();
  });

  group('MonthsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<MonthsBloc>());
    });
  });
}
