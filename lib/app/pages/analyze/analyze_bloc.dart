import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:rxdart/rxdart.dart';

class AnalyzeBloc extends BlocBase {

  final TaskModel task;

  BehaviorSubject<StepsEnum> _step = BehaviorSubject();

  AnalyzeBloc(this.task);

  Observable<StepsEnum> get step => _step.stream;

  Function(StepsEnum) get changeStep => _step.sink.add;

  void goTo(StepsEnum step) => changeStep(step);

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _step.close();
    super.dispose();
  }
}
