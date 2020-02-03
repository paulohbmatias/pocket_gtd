import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/routines/routines_bloc.dart';
import 'package:pocket_gtd/app/modules/routines/routines_module.dart';
import 'package:pocket_gtd/app/modules/routines/widgets/list_routines/list_routines_widget.dart';

class RoutinesPage extends StatefulWidget {
  final String title;
  const RoutinesPage({Key key, this.title = "Routines"}) : super(key: key);

  @override
  _RoutinesPageState createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {

  final bloc = RoutinesModule.to.bloc<RoutinesBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(
          color: Colors.black
        ),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListRoutinesWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.add(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
