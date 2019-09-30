import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/modules/dashboard/dashboard_bloc.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

class DashboardPage extends StatelessWidget {
  DashboardBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<DashboardBloc>(context);
    return Scaffold(
      body: StreamBuilder<int>(
        stream: bloc.page,
        initialData: 0,
        builder: (_, snapshot) => pages[snapshot.data],
      ),
      floatingActionButton: UnicornDialer(
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: <UnicornButton>[
            UnicornButton(
                hasLabel: true,
                labelText: "Choo choo",
                currentButton: FloatingActionButton(
                  heroTag: "train",
                  backgroundColor: Colors.redAccent,
                  mini: true,
                  child: Icon(Icons.train),
                  onPressed: () {},
                )),
            UnicornButton(
                hasLabel: true,
                labelText: "Choo choo",
                currentButton: FloatingActionButton(
                  heroTag: "train",
                  backgroundColor: Colors.redAccent,
                  mini: true,
                  child: Icon(Icons.train),
                  onPressed: () {},
                )),
          ]),
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
        Container(),
        Container(),
        Container(),
      ];
}
