import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/one_day_maybe/one_day_maybe_bloc.dart';
import 'package:pocket_gtd/app/modules/one_day_maybe/one_day_maybe_module.dart';

void main() {
  initModule(OneDayMaybeModule());
  OneDayMaybeBloc bloc;

  setUp(() {
    bloc = OneDayMaybeModule.to.bloc<OneDayMaybeBloc>();
  });

  group('OneDayMaybeBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<OneDayMaybeBloc>());
    });
  });
}
