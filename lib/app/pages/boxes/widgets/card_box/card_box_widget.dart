import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardBoxWidget extends StatelessWidget {

  final BoxModel box;

  CardBoxWidget(this.box);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: Icon(MdiIcons.package, size: 48,),
      title: Text(box.title),
      subtitle: Text(S.of(context).files_x(box.length.toString())),
    );
  }
}
