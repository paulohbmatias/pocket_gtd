import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/modules/register/register_bloc.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterTaskBottomSheetWidget extends StatelessWidget {
  final bloc = RegisterModule.to.bloc<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: bloc.contentController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none, color: Colors.green)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none, color: Colors.green)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none, color: Colors.green)),
                      hintText: I18n.of(context).content,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    onChanged: bloc.changeDescription,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    StreamBuilder<String>(
                        stream: bloc.deadline,
                        initialData: "",
                        builder: (context, snapshot) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  snapshot.data.isEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(I18n.of(context).deadline,
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        )
                                      : Container(),
                                  Text(snapshot.data),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Icon(
                                        MdiIcons.alarmPlus,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          firstDate: DateTime.now()
                                              .subtract(Duration(days: 1)),
                                          lastDate: DateTime(2060),
                                        );
                                        if (date == null) return;
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
                    StreamBuilder<bool>(
                        stream: bloc.isValidFields(context),
                        initialData: false,
                        builder: (context, snapshot) {
                          return Container(
                            child: IconButton(
                              color: Theme.of(context).accentColor,
                              icon: Icon(Icons.done),
                              onPressed: snapshot.hasData && snapshot.data
                                  ? () => bloc.isUpdate
                                      ? bloc.updateTask(context)
                                      : bloc.saveTask(context)
                                  : null,
                            ),
                          );
                        })
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
