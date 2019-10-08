import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_widget.dart';

class ListTasksPage extends StatelessWidget {

  final BoxModel box;

  ListTasksPage(this.box);

  @override
  Widget build(BuildContext context) {
    return ListDefaultWidget();
  }
}
