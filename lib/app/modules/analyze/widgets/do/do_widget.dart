import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/modules/analyze/widgets/do/do_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DoWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<DoBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(I18n.of(context).app_pages_analyze_do_title),
      content: LinearProgressIndicator(),
      actions: <Widget>[
        FlatButton(onPressed: () {
          bloc.done();
          Navigator.of(context).pop();
        }, child: Text(I18n.of(context).done)),
      ],
    );
  }
}
