import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/modules/boxes/widgets/list_boxes/list_boxes_bloc.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class CardBoxWidget extends StatelessWidget {
  final bloc = BoxesModule.to.bloc<ListBoxesBloc>();

  final BoxModel box;

  CardBoxWidget(this.box);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => bloc.openBox(context, box),
      contentPadding: const EdgeInsets.all(8),
      leading: Icon(
        IconData(
          box.icon.codePoint,
          fontFamily: box.icon.fontFamily,
          fontPackage: box.icon.fontPackage,
          matchTextDirection: box.icon.matchTextDirection
        ),
        size: 32,
      ),
      title: Text(BoxModel.getBoxName(context, box)),
      subtitle: Text(I18n.of(context).files_x(box.length.toString())),
    );
  }
}
