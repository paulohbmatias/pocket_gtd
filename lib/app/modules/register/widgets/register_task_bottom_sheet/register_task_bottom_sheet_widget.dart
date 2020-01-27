import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/register/register_bloc.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterTaskBottomSheetWidget extends StatelessWidget {
  final bloc = RegisterModule.to.bloc<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: bloc.titleController,
                      textCapitalization: TextCapitalization.sentences,
                      autofocus: true,
                      focusNode: FocusNode(canRequestFocus: true),
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
                      onChanged: bloc.changeTitle,
                    ),
                  ),
                  StreamBuilder<String>(
                      stream: bloc.deadline,
                      initialData: "",
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data.isNotEmpty
                            ? Container(
                                alignment: Alignment.centerLeft,
                                // padding: const EdgeInsets.all(value),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Chip(
                                    label: Text(
                                      snapshot.data,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    avatar: Icon(
                                      MdiIcons.calendarCheck,
                                      size: 16,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: Colors.grey, width: .2)),
                                    deleteIcon: Icon(
                                      Icons.clear,
                                      color: Colors.black54,
                                      size: 16,
                                    ),
                                    onDeleted: () {
                                      bloc.changeDeadline(null);
                                    },
                                    backgroundColor: Colors.transparent,
                                  ),
                                ))
                            : Container();
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            // padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                OMIcons.notes,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  initialDatePickerMode: DatePickerMode.day,
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 1)),
                                  lastDate: DateTime(2060),
                                );
                                if (date == null) return;
                                final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());

                                DateTime when = DateTime(date.year, date.month,
                                    date.day, time.hour, time.minute);

                                bloc.changeDeadline(when);
                              },
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                MdiIcons.calendarCheck,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  initialDatePickerMode: DatePickerMode.day,
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 1)),
                                  lastDate: DateTime(2060),
                                );
                                if (date == null) return;
                                final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());

                                DateTime when = DateTime(date.year, date.month,
                                    date.day, time.hour, time.minute);

                                bloc.changeDeadline(when);
                              },
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder<bool>(
                          stream: bloc.isValidFields(context),
                          initialData: false,
                          builder: (context, snapshot) {
                            return Container(
                              child: FlatButton(
                                textColor: Theme.of(context).primaryColor,
                                child: Text(I18n.of(context).save),
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
      ),
    );
  }
}
