import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/register/register_bloc.dart';

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
          child: Text("Cancel"),
        ),
        FlatButton(
          onPressed: (){},
          child: Text("Save"),
        )
      ],
      title: Text("Register task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Title"),
          ),
          TextField(
            decoration: InputDecoration(hintText: "Description"),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "Description", icon: Icon(Icons.event)),
          )
        ],
      ),
    );
  }
}
