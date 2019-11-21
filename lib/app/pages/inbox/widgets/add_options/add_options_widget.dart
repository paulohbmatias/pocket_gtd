import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/add_options/add_options_bloc.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/enums/task_type.dart';
import 'package:pocket_gtd/app/shared/widgets/fab_circular.dart';

class AddOptionsWidget extends StatelessWidget {
  final bloc = InboxModule.to.bloc<AddOptionsBloc>();

  AddOptionsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
        buttonState: bloc.buttonOpen,
        fabOpenIcon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        fabCloseIcon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
        fabColor: Theme.of(context).primaryColor,
        ringColor: Theme.of(context).primaryColor,
        ringWidth: 100,
        fabMargin: EdgeInsets.all(8),
        ringDiameter: 300,
        child: Container(),
        options: <Widget>[
          IconButton(
              icon: Icon(
                MdiIcons.folderOpen,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => bloc.add(context, ListTypeEnum.REFERENCES)),
          IconButton(
              icon: Icon(
                MdiIcons.packageVariant,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => bloc.add(context, ListTypeEnum.BOXES)),
          IconButton(
              icon: Icon(
                MdiIcons.noteText,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => bloc.add(context, ListTypeEnum.DEFAULT)),
        ]);
  }
}
