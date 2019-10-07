import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/widgets/register_task/register_task_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterTaskWidget extends StatelessWidget {
  final bloc = AppModule.to.getBloc<RegisterTaskBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        FlatButton(
          onPressed: () => bloc.cancelDialog(context),
          child: Text(S.of(context).cancel),
        ),
        FlatButton(
          onPressed: () {},
          child: Text(S.of(context).save),
        )
      ],
      title: Text(S.of(context).register_task),
      content: FutureBuilder<List<BoxModel>>(
          future: bloc.getBoxes(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        decoration:
                            InputDecoration(hintText: S.of(context).title),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: S.of(context).description),
                      ),
                      StreamBuilder<BoxModel>(
                          stream: bloc.box,
                          initialData: snapshot.data.first,
                          builder: (context, boxSelected) {
                            return DropdownButton<BoxModel>(
                              value: boxSelected.data,
                              onChanged: bloc.changeBox,
                              items: snapshot.data
                                  .map<DropdownMenuItem<BoxModel>>(
                                      (value) => DropdownMenuItem(
                                          value: value,
                                          child: ListTile(
                                            leading: Icon(MdiIcons.package),
                                            title: Text(value.title),
                                          )))
                                  .toList(),
                            );
                          }),
                      TextField(
                        decoration: InputDecoration(
                            hintText: S.of(context).deadline,
                            icon: Icon(Icons.event)),
                      )
                    ],
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
