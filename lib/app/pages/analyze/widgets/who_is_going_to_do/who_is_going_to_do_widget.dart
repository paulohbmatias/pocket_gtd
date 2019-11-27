import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_bloc.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/enums/steps_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class WhoIsGoingToDoWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<AnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).app_pages_analyze_who_is_going_to_do_title),
      content: Text(S.of(context).app_pages_analyze_who_is_going_to_do_content),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.DELEGATE), child: Text(S.of(context).someone_else)),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.IS_IT_TEMPORAL), child: Text(S.of(context).me))
      ],
    );
  }
}
