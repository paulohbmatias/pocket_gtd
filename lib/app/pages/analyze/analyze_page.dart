import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class AnalyzePage extends StatefulWidget {
  final TaskModel task;
  const AnalyzePage({Key key, @required this.task}) : super(key: key);

  @override
  _AnalyzePageState createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task.title),
      content: Text("Pergunta"),
      actions: <Widget>[
        FlatButton(child: Text("Sim"), onPressed: (){},),
        FlatButton(child: Text("Não"), onPressed: (){},),
      ],
    );
  }
}
