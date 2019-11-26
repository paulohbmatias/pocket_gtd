import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/app/pages/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/pages/next_actions/next_actions_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DashboardPage extends StatefulWidget {

  final int page;

  DashboardPage({this.page = 0});

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
//      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: false,
        title: StreamBuilder<int>(
          stream: bloc.page,
          initialData: widget.page ?? 0,
          builder: (context, snapshot){
            switch(snapshot.data){
              case 0: return Text(S.of(context).inbox);
              case 1: return Text(S.of(context).next_actions);
              case 2: return Text(S.of(context).boxes);
              default: return Text(S.of(context).inbox);
            }
          },
        ),
      ),
      body: StreamBuilder<int>(
        stream: bloc.page,
        initialData: widget.page ?? 0,
        builder: (_, snapshot) => pages[snapshot.data],
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: bloc.page,
          initialData: widget.page ?? 0,
          builder: (_, snapshot) => BottomNavigationBar(
                unselectedItemColor: Theme.of(context).unselectedWidgetColor,
                selectedItemColor: Theme.of(context).accentColor,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                items: <BottomNavigationBarItem>[
                  bottomItem(MdiIcons.inbox, S.of(context).inbox),
                  bottomItem(OMIcons.listAlt, S.of(context).next_actions),
//                  bottomItem(MdiIcons.contentPaste, S.of(context).references),
                  bottomItem(MdiIcons.cube, S.of(context).boxes),
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
          size: 30,
        ),
        title: Text(
          title,
        ));
  }

  List<Widget> get pages => [
        InboxModule(),
        NextActionsModule(),
//        Container(),
        BoxesModule(),
      ];
}
