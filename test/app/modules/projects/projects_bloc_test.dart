import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:pocket_gtd/app/modules/projects/projects_bloc.dart';
import 'package:pocket_gtd/app/modules/projects/projects_module.dart';

void main() {
  initModule(ProjectsModule());
  ProjectsBloc bloc;

  setUp(() {
    bloc = ProjectsModule.to.bloc<ProjectsBloc>();
  });

  group('ProjectsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<ProjectsBloc>());
    });
  });
}
