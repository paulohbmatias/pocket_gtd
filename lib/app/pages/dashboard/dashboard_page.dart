import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:unicorndial/unicorndial.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardBloc bloc = DashboardModule.to.getBloc<DashboardBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: bloc.page,
        initialData: 0,
        builder: (_, snapshot) => pages[snapshot.data],
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: bloc.page,
          initialData: 1,
          builder: (_, snapshot) => BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.inbox), title: Text("inbox")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.view_list), title: Text("Next actions")),
                  BottomNavigationBarItem(
                      icon: Icon(MdiIcons.inboxMultiple), title: Text("Boxes")),
                ],
                currentIndex: snapshot.data,
                onTap: bloc.changePage,
              )),
    );
  }

  List<Widget> get pages => [
        InboxModule(),
        Container(),
        Container(),
      ];
}
