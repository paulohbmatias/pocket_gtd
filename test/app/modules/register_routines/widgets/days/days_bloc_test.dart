import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/register_routines/widgets/days/days_bloc.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';

void main() {
  initModule(RegisterRoutinesModule());
  DaysBloc bloc;

  setUp(() {
    bloc = RegisterRoutinesModule.to.bloc<DaysBloc>();
  });

  group('DaysBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<DaysBloc>());
    });
  });
}
