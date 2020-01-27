import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/modules/home/home_module.dart';
import 'package:pocket_gtd/app/modules/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/modules/projects/projects_module.dart';
import 'package:pocket_gtd/app/modules/references/references_module.dart';
import 'package:pocket_gtd/app/modules/scheduled/scheduled_module.dart';
import 'package:pocket_gtd/app/modules/tasks/tasks_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class DashboardPage2 extends StatefulWidget {
  final int page;

  DashboardPage2({this.page = 0});

  @override
  _DashboardPage2State createState() => _DashboardPage2State();
}

class _DashboardPage2State extends State<DashboardPage2> {
  DashboardBloc bloc = DashboardModule.to.getBloc<DashboardBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FontWeight fontWeight = FontWeight.normal;
  final textColor = Colors.black;
  final initialPage = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // textTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 16)),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Pocket GTD",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Icon(Icons.search, color: Theme.of(context).primaryColor,),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScheduledModule()
                  ));
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: StreamBuilder<int>(
          stream: bloc.page,
          initialData: widget.page ?? initialPage,
          builder: (context, snapshot) {
            return snapshot.hasData && snapshot.data == 1
                ? FloatingActionButton(
                    onPressed: () => bloc.add(context, ListTypeEnum.INBOX),
                    child: Icon(Icons.add),
                  )
                : FloatingActionButton(
                    onPressed: () => bloc.add(context, ListTypeEnum.INBOX),
                    child: Icon(Icons.add),
                  );
          },
        ),
        body: StreamBuilder<int>(
          stream: bloc.page,
          initialData: widget.page ?? initialPage,
          builder: (_, snapshot) => pages[snapshot.data],
        ),
        bottomNavigationBar: StreamBuilder<int>(
            stream: bloc.page,
            initialData: widget.page ?? initialPage,
            builder: (_, snapshot) => BubbleBottomBar(
                  items: [
                    bottomItem(
                        OMIcons.inbox, MdiIcons.inbox, I18n.of(context).inbox),
                    bottomItem(OMIcons.listAlt, OMIcons.listAlt,
                        I18n.of(context).tasks),
                    bottomItem(OMIcons.widgets, MdiIcons.widgets,
                        I18n.of(context).projects),
                  ],

                  opacity: .2,
                  elevation: 100,
                  inkColor: Colors.black,
                  // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  fabLocation: BubbleBottomBarFabLocation.end,
                  hasInk: true,
                  hasNotch: true,
                  // selectedColor: Theme.of(context).primaryColor,
                  currentIndex: snapshot.data,
                  // indicatorColor: Theme.of(context).primaryColor,
                  onTap: bloc.changePage,
                )),
      ),
    );
  }

  BubbleBottomBarItem bottomItem(
      IconData icon, IconData activeIcon, String title) {
    return BubbleBottomBarItem(
        backgroundColor: Colors.grey,
        icon: Icon(
          icon,
          size: 30,
          color: Colors.black,
        ),
        activeIcon: Icon(
          activeIcon,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'roboto', color: Theme.of(context).primaryColor),
        ));
  }

  final pages = [
    InboxModule(),
    TasksModule(),
    ProjectsModule(),
  ];
}
