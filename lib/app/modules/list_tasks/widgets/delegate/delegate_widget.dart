import 'package:flutter/material.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DelegateWidget extends StatelessWidget {
  String who = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(who);
          },
          child: Text(I18n.of(context).delegate_task),
        )
      ],
      title: Text(I18n.of(context).app_pages_analyze_delegate_title),
      content: TextField(
        onChanged: (value) => who = value,
        decoration: InputDecoration(
          hintText: I18n.of(context).name
        ),
      ),
    );
  }
}
