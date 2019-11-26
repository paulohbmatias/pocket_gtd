import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';

class TwoMinutesBloc extends BlocBase {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  void goTo(BuildContext context, StepsEnum step){
    bloc.changeStep(step);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
