import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:rxdart/rxdart.dart';

class AnalyzeBloc extends BlocBase {

  BehaviorSubject<StepsEnum> _step = BehaviorSubject();

  Observable<StepsEnum> get step => _step.stream;

  Function(StepsEnum) get changeStep => _step.sink.add;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _step.close();
    super.dispose();
  }
}
