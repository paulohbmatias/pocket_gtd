import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';

class ActionableBloc extends BlocBase {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  void goTo(BuildContext context, StepsEnum step){
    bloc.changeStep(step);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
