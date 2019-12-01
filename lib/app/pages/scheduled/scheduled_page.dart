import 'package:flutter/material.dart';

class ScheduledPage extends StatefulWidget {
  final String title;
  const ScheduledPage({Key key, this.title = "Scheduled"}) : super(key: key);

  @override
  _ScheduledPageState createState() => _ScheduledPageState();
}

class _ScheduledPageState extends State<ScheduledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
