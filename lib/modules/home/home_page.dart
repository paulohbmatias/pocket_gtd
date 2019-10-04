import 'package:flutter/material.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(S.of(context).login),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text(S.of(context).sign_up),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
