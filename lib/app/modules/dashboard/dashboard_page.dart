import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/modules/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/modules/next_actions/next_actions_module.dart';
import 'package:pocket_gtd/app/modules/scheduled/scheduled_module.dart';
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

  final initialPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: false,
        title: StreamBuilder<int>(
          stream: bloc.page,
          initialData: widget.page ?? initialPage,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case 0:
                return Text(I18n.of(context).inbox);
              case 1:
                return Text(I18n.of(context).next_actions);
              case 2:
                return Text(I18n.of(context).scheduled);
              case 3:
                return Text(I18n.of(context).boxes);
              default:
                return Text(I18n.of(context).inbox);
            }
          },
        ),
      ),
      body: StreamBuilder<int>(
        stream: bloc.page,
        initialData: widget.page ?? initialPage,
        builder: (_, snapshot) => pages[snapshot.data],
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: bloc.page,
          initialData: widget.page ?? initialPage,
          builder: (_, snapshot) => BottomNavigationBar(
                unselectedItemColor: Theme.of(context).unselectedWidgetColor,
                selectedItemColor: Theme.of(context).accentColor,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                items: <BottomNavigationBarItem>[
                  bottomItem(OMIcons.inbox, I18n.of(context).inbox),
                  bottomItem(OMIcons.notes, I18n.of(context).next_actions),
                  bottomItem(
                      MdiIcons.calendarOutline, I18n.of(context).scheduled),
                  bottomItem(MdiIcons.cube, I18n.of(context).boxes),
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
        ScheduledModule(),
        BoxesModule(),
      ];
}
