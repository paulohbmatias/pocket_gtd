import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_bloc.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/pages/boxes/widgets/list_boxes/list_boxes_widget.dart';

class BoxesPage extends StatefulWidget {
  @override
  _BoxesPageState createState() => _BoxesPageState();
}

class _BoxesPageState extends State<BoxesPage> {

  final bloc = BoxesModule.to.bloc<BoxesBloc>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListBoxesWidget(),
    );
  }

}
  