import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/register_routines/widgets/years/years_bloc.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';

void main() {
  initModule(RegisterRoutinesModule());
  YearsBloc bloc;

  setUp(() {
    bloc = RegisterRoutinesModule.to.bloc<YearsBloc>();
  });

  group('YearsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<YearsBloc>());
    });
  });
}
