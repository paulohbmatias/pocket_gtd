import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/pages/list_tasks/widgets/list_default/list_default_widget.dart';

class ListTasksPage extends StatelessWidget {
  final ListTypeEnum listType;
  final int pageToBack;

  ListTasksPage(this.listType, {this.pageToBack});

  @override
  Widget build(BuildContext context) {
    if (listType == ListTypeEnum.DEFAULT)
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
        ),
        child: ListDefaultWidget(listType),
      );
    else
      return ListDefaultWidget(listType);
  }
}
