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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: StreamBuilder<int>(
          stream: bloc.page,
          initialData: 1,
          builder: (_, snapshot) => BubbleBottomBar(
                opacity: .2,
                currentIndex: snapshot.data,
                onTap: bloc.changePage,
                iconSize: 32,
                backgroundColor: Theme.of(context).primaryColor,
                fabLocation: BubbleBottomBarFabLocation.end, //new
                hasNotch: true, //new
                hasInk: true, //new, gives a cute ink effect
                inkColor: Colors
                    .black12, //optional, uses theme color if not specified
                items: <BubbleBottomBarItem>[
                  bottomItem(Icons.inbox, Colors.white, S.of(context).inbox),
                  bottomItem(Icons.view_list, Colors.white, S.of(context).next_actions),
                  bottomItem(Icons.folder_open, Colors.white, S.of(context).references),
                  bottomItem(MdiIcons.inboxMultiple, Colors.white, S.of(context).boxes),
                ],
              )),
    );
  }

  BubbleBottomBarItem bottomItem(IconData icon, Color color, String title) {
    return BubbleBottomBarItem(
        backgroundColor: color,
        icon: Icon(
          icon,
          color: color,
        ),
        activeIcon: Icon(
          icon,
          color: color,
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
