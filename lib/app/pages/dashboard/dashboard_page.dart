import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardBloc bloc = DashboardModule.to.getBloc<DashboardBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(),
      body: StreamBuilder<int>(
        stream: bloc.page,
        initialData: 0,
        builder: (_, snapshot) => pages[snapshot.data],
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: bloc.page,
          initialData: 1,
          builder: (_, snapshot) => BottomNavigationBar(
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
            selectedItemColor: Theme.of(context).primaryColor,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              bottomItem(Icons.inbox, S.of(context).inbox),
              bottomItem(Icons.view_list, S.of(context).next_actions),
              bottomItem(Icons.folder_open, S.of(context).references),
              bottomItem(MdiIcons.inboxMultiple, S.of(context).boxes),
            ],
            currentIndex: snapshot.data,
            onTap: bloc.changePage,
          )),
    );
  }

  BottomNavigationBarItem bottomItem(IconData icon, String title) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          semanticLabel: "LLL",
        ),
        title: Text(
          title,
        ));
  }

  List<Widget> get pages => [
        InboxModule(),
        Container(),
        Container(),
        BoxesModule(),
      ];
}
