import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/pages/analyze/widgets/delegate/delegate_bloc.dart';

class DelegateWidget extends StatelessWidget {

  final bloc = AnalyzeModule.to.bloc<DelegateBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Who will accomplish this task?"),
      content: TextField(
        onChanged: bloc.changeName,
        decoration: InputDecoration(
          hintText: "Name"
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
            } : null, child: Text("Done"),);
          }
        )
      ],
    );
  }
}
