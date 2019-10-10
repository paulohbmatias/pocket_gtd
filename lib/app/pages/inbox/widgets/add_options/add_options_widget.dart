import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/add_options/add_options_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';

class AddOptionsWidget extends StatelessWidget {

  final bloc = InboxModule.to.bloc<AddOptionsBloc>();

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
        fabOpenIcon: Icon(Icons.add, color: Colors.white,),
        ringColor: Theme.of(context).primaryColor,
        fabMargin: EdgeInsets.all(8),
        ringDiameter: 200,
        child: Container(),
        options: <Widget>[
          IconButton(
              icon: Icon(
                MdiIcons.folderOpen,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => bloc.add(context, AddOptionsEnum.REFERENCE)),
          IconButton(
              icon: Icon(
                MdiIcons.packageVariant,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => bloc.add(context, AddOptionsEnum.BOX)),
          IconButton(
              icon: Icon(
                MdiIcons.noteText,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => bloc.add(context, AddOptionsEnum.TASK)),
        ]);
  }
}
