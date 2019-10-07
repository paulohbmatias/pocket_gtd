import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/pages/inbox/widgets/add_options/add_options_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:unicorndial/unicorndial.dart';

class AddOptionsWidget extends StatelessWidget {

  final bloc = InboxModule.to.bloc<AddOptionsBloc>();

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
        fabOpenIcon: Icon(Icons.add),
        ringColor: Colors.blueGrey,
        ringDiameter: 200,
        child: Container(),
        options: <Widget>[
          IconButton(
              icon: Icon(
                MdiIcons.folderOpen,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                print('Pressed!');
              }),
          IconButton(
              icon: Icon(
                MdiIcons.packageVariant,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                print('Pressed!');
              }),
          IconButton(
              icon: Icon(
                MdiIcons.noteText,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => bloc.addTask(context)),
        ]);
    return UnicornDialer(
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: <UnicornButton>[
          UnicornButton(
              hasLabel: true,
              labelText: S.of(context).task,
              labelBackgroundColor: Colors.transparent,
              labelHasShadow: false,
              currentButton: FloatingActionButton(
                heroTag: "task",
                mini: true,
                child: Icon(MdiIcons.noteText),
                onPressed: () {},
              )),
          UnicornButton(
              hasLabel: true,
              labelText: S.of(context).project,
              labelBackgroundColor: Colors.transparent,
              labelHasShadow: false,
              currentButton: FloatingActionButton(
                heroTag: "project",
                mini: true,
                child: Icon(Icons.computer),
                onPressed: () {},
              )),
          UnicornButton(
              hasLabel: true,
              labelText: S.of(context).event,
              labelBackgroundColor: Colors.transparent,
              labelHasShadow: false,
              currentButton: FloatingActionButton(
                heroTag: "event",
                mini: true,
                child: Icon(Icons.event),
                onPressed: () {},
              )),
          UnicornButton(
              hasLabel: true,
              labelText: S.of(context).reference,
              labelBackgroundColor: Colors.transparent,
              labelHasShadow: false,
              currentButton: FloatingActionButton(
                heroTag: "reference",
                mini: true,
                child: Icon(MdiIcons.fileOutline),
                onPressed: () {},
              )),
        ]);
  }
}
