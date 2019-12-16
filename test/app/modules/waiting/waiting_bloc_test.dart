import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/waiting/waiting_bloc.dart';
import 'package:pocket_gtd/app/modules/waiting/waiting_module.dart';

void main() {
  initModule(WaitingModule());
  WaitingBloc bloc;

  setUp(() {
    bloc = WaitingModule.to.bloc<WaitingBloc>();
  });

  group('WaitingBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<WaitingBloc>());
    });
  });
}
