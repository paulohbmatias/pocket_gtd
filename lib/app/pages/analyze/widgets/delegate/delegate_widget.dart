import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/delegate/delegate_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DelegateWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<DelegateBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(I18n.of(context).app_pages_analyze_delegate_title),
      content: TextField(
        onChanged: bloc.changeName,
        decoration: InputDecoration(
          hintText: I18n.of(context).name
        ),
      ),
      actions: <Widget>[
        StreamBuilder<bool>(
          stream: bloc.isEmpty,
          initialData: true,
          builder: (context, snapshot) {
            return FlatButton(onPressed: !snapshot.data ? () {
              bloc.done();
              Navigator.of(context).pop();
            } : null, child: Text(I18n.of(context).done));
          }
        )
      ],
    );
  }
}
