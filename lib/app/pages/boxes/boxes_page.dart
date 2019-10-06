import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/boxes/widgets/list_boxes/list_boxes_widget.dart';
import 'package:pocket_gtd/app/pages/boxes/widgets/register/register_widget.dart';

class BoxesPage extends StatefulWidget {
  @override
  _BoxesPageState createState() => _BoxesPageState();
}

class _BoxesPageState extends State<BoxesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListBoxesWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAlert(context),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(context: context, builder: (context) => RegisterWidget());
  }
}
  