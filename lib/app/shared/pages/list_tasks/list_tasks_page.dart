import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_widget.dart';

class ListTasksPage extends StatelessWidget {
  final ListTypeEnum listType;
  final BoxModel box;
  final int pageToBack;

  ListTasksPage(this.listType, this.box, {this.pageToBack});

  @override
  Widget build(BuildContext context) {
    if (listType == ListTypeEnum.DEFAULT)
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(box.title),
        ),
        child: ListDefaultWidget(listType),
      );
    else
      return ListDefaultWidget(listType);
  }
}
