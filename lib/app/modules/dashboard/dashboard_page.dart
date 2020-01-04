import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_bloc.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/modules/inbox/inbox_module.dart';
import 'package:pocket_gtd/app/modules/projects/projects_module.dart';
import 'package:pocket_gtd/app/modules/references/references_module.dart';
import 'package:pocket_gtd/app/modules/tasks/tasks_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
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
          title: StreamBuilder<int>(
            stream: bloc.page,
            initialData: widget.page ?? initialPage,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case 0:
                  return Text(
                    I18n.of(context).tasks,
                    style: TextStyle(color: textColor, fontWeight: fontWeight),
                  );
                case 1:
                  return Text(
                    I18n.of(context).projects,
                    style: TextStyle(color: textColor, fontWeight: fontWeight),
                  );
                default:
                  return Text(
                    I18n.of(context).tasks,
                    style: TextStyle(color: textColor, fontWeight: fontWeight),
                  );
              }
            },
          ),
        ),
        drawer: Drawer(),
        floatingActionButton: StreamBuilder<int>(
          stream: bloc.page,
          initialData: widget.page ?? initialPage,
          builder: (context, snapshot) {
            return snapshot.hasData && snapshot.data == 0
                ? FloatingActionButton(
                    onPressed: () => bloc.add(context, ListTypeEnum.INBOX),
                    child: Icon(Icons.add),
                  )
                : Container();
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
            builder: (_, snapshot) => BottomNavigationBar(
                  unselectedItemColor: Theme.of(context).unselectedWidgetColor,
                  selectedItemColor: Theme.of(context).accentColor,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.shifting,
                  showSelectedLabels: true,
                  items: <BottomNavigationBarItem>[
                    bottomItem(OMIcons.listAlt, I18n.of(context).tasks),
                    bottomItem(
                        OMIcons.widgets, I18n.of(context).projects),
                  ],
                  currentIndex: snapshot.data,
                  onTap: bloc.changePage,
                )),
      ),
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

  final pages = [
        TasksModule(),
        ProjectsModule(),
      ];
}
