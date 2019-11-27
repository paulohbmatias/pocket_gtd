import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/do/do_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DoWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<DoBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).app_pages_analyze_do_title),
      content: LinearProgressIndicator(),
      actions: <Widget>[
        FlatButton(onPressed: () {
          bloc.done();
          Navigator.of(context).pop();
        }, child: Text(S.of(context).done)),
      ],
    );
  }
}
