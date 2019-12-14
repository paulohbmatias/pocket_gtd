import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/dashboard/widgets/app_bar/app_bar_bloc.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_module.dart';

void main() {
  initModule(DashboardModule());
  AppBarBloc bloc;

  setUp(() {
    bloc = DashboardModule.to.bloc<AppBarBloc>();
  });

  group('AppBarBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AppBarBloc>());
    });
  });
}
