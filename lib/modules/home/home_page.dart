import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Login"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
