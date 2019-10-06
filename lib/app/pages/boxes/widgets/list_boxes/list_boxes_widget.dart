import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/pages/boxes/widgets/list_boxes/list_boxes_bloc.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';

class ListBoxesWidget extends StatelessWidget {
  final bloc = BoxesModule.to.bloc<ListBoxesBloc>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BoxModel>>(
        stream: bloc.boxes,
        initialData: <BoxModel>[],
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: ListView(
              children: snapshot.data.map((box) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: Icon(MdiIcons.package),
                  title: Text(box.title),
                  trailing: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){}),
                );
              }).toList(),
            ),
          );
        });
  }
}
