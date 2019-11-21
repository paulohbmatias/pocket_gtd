import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/pages/next_actions/next_actions_module.dart';
import 'package:pocket_gtd/app/pages/references/references_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DashboardPage extends StatefulWidget {

  final int page;

  DashboardPage({this.page = 0});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardBloc bloc = DashboardModule.to.getBloc<DashboardBloc>();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: true,
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          bottomItem(Icons.inbox, S.of(context).inbox),
          bottomItem(Icons.view_list, S.of(context).next_actions),
          bottomItem(Icons.folder_open, S.of(context).references),
          bottomItem(MdiIcons.inboxMultiple, S.of(context).boxes),
        ],
        onTap: bloc.changePage,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(
          child: CupertinoTabView(
            builder: (BuildContext context) {
              return StreamBuilder<int>(
                stream: bloc.page,
                initialData: widget.page ?? 0,
                builder: (_, snapshot) => pages[snapshot.data],
              );
            },
          ),
        );
      },
    );
  }

  BottomNavigationBarItem bottomItem(IconData icon, String title) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
        ),
        title: Text(
          title,
        ));
  }

  List<Widget> get pages => [
        InboxModule(),
        NextActionsModule(),
        ReferencesModule(),
        BoxesModule(),
      ];
}
