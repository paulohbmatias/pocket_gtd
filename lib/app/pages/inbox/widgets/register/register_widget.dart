import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/register/register_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterWidget extends StatelessWidget {

  final bloc = InboxModule.to.getBloc<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => bloc.cancelDialog(context),
          child: Text(S.of(context).cancel),
        ),
        FlatButton(
          onPressed: (){},
          child: Text(S.of(context).save),
        )
      ],
      title: Text(S.of(context).register_task),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: S.of(context).title),
          ),
          TextField(
            decoration: InputDecoration(hintText: S.of(context).description),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: S.of(context).deadline, icon: Icon(Icons.event)),
          )
        ],
      ),
    );
  }
}
