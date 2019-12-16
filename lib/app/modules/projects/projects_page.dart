import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';

class ProjectsPage extends StatefulWidget {
  final String title;
  const ProjectsPage({Key key, this.title = "Projects"}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyListWidget(
        "Calma aí, ainda to fazendo essa parte. Se tiver com pressa, contribui lá no github.",
        image: "assets/images/doing.png",
      )
    );
  }
}
