import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/register/register_bloc.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterTaskWidget extends StatefulWidget {
  @override
  _RegisterTaskWidgetState createState() => _RegisterTaskWidgetState();
}

class _RegisterTaskWidgetState extends State<RegisterTaskWidget> {
  final bloc = RegisterModule.to.getBloc<RegisterBloc>();
  Future<List<BoxModel>> futureBoxes;
  DateTime picked;

  @override
  void initState() {
    futureBoxes = bloc.getBoxes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: bloc.scaffoldKey,
        appBar: AppBar(
          title: Text(
            I18n.of(context).register,
          ),
          actions: <Widget>[
            StreamBuilder<bool>(
                stream: bloc.isValidFields(context),
                initialData: false,
                builder: (context, snapshot) {
                  return IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(
                      OMIcons.done,
                      color: Colors.white,
                    ),
                    onPressed: snapshot.hasData && snapshot.data
                        ? () => bloc.isUpdate
                            ? bloc.updateTask(context)
                            : bloc.saveTask(context)
                        : null,
                  );
                })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: bloc.detailsController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: I18n.of(context).content,
                        ),
                        maxLines: 4,
                        minLines: 2,
                        onChanged: bloc.changeDetails,
                      ),
                    ),
                    bloc.isUpdate ? StreamBuilder<String>(
                        stream: bloc.schedule,
                        initialData: "",
                        builder: (context, snapshot) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(I18n.of(context).schedule_for,
                                      style: TextStyle(color: Colors.grey)),
                                  Text(snapshot.data),
                                  IconButton(
                                    icon: Icon(
                                      MdiIcons.alarmPlus,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () async{
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        initialDatePickerMode:
                                            DatePickerMode.day,
                                        firstDate: DateTime.now()
                                            .subtract(Duration(days: 1)),
                                        lastDate: DateTime(2060),
                                      );
                                      if(date == null) return;
                                      final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());

                                      DateTime when = DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          time.hour,
                                          time.minute);

                                      bloc.changeSchedule(when);
                                    },
                                  )
                                ],
                              ));
                        }) : Container(),
                    StreamBuilder<String>(
                        stream: bloc.deadline,
                        initialData: "",
                        builder: (context, snapshot) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(I18n.of(context).deadline,
                                        style: TextStyle(color: Colors.grey)),
                                  ),
                                  Text(snapshot.data),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Icon(
                                        MdiIcons.alarmPlus,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async{
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          firstDate: DateTime.now()
                                              .subtract(Duration(days: 1)),
                                          lastDate: DateTime(2060),
                                        );
                                        if(date == null) return;
                                        final time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());

                                        DateTime when = DateTime(
                                            date.year,
                                            date.month,
                                            date.day,
                                            time.hour,
                                            time.minute);

                                        bloc.changeDeadline(when);
                                      },
                                    ),
                                  )
                                ],
                              ));
                        }),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
