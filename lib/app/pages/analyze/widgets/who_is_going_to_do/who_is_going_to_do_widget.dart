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
      title: Text(I18n.of(context).app_pages_analyze_who_is_going_to_do_title),
      content: Text(I18n.of(context).app_pages_analyze_who_is_going_to_do_content),
      actions: <Widget>[
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.DELEGATE), child: Text(I18n.of(context).someone_else)),
        FlatButton(onPressed: () => bloc.goTo(StepsEnum.ARE_PROJECT), child: Text(I18n.of(context).me))
      ],
    );
  }
}
