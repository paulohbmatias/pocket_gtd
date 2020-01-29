import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/register/register_bloc.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/app/shared/models/priority_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterTaskBottomSheetWidget extends StatelessWidget {
  final bloc = RegisterModule.to.bloc<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: TextField(
                  controller: bloc.titleController,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                  // focusNode: FocusNode(canRequestFocus: true),
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
              StreamBuilder<bool>(
                stream: bloc.openDetails,
                initialData: false,
                builder: (context, snapshot) {
                  return snapshot.data
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: TextField(
                            controller: bloc.detailsController,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.green)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.green)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.green)),
                              hintText: I18n.of(context).details,
                            ),
                            maxLines: 4,
                            minLines: 1,
                            onChanged: bloc.changeDetails,
                          ),
                        )
                      : Container();
                },
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
              StreamBuilder<PriorityEnum>(
                  stream: bloc.priority,
                  initialData: PriorityEnum.NORMAL,
                  builder: (context, snapshot) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: CupertinoSegmentedControl<PriorityEnum>(
                        onValueChanged: bloc.changePriority,
                        groupValue: snapshot.data,
                        padding: const EdgeInsets.all(8),
                        children: {
                          PriorityEnum.LOW: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Text(
                              I18n.of(context).low,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          PriorityEnum.NORMAL: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              I18n.of(context).normal,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          PriorityEnum.HIGH: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              I18n.of(context).high,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          PriorityEnum.URGENT: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              I18n.of(context).urgent,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        },
                      ),
                    );
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
                          onPressed: () => bloc.changeOpenDetails(true),
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
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 1)),
                              lastDate: DateTime(2060),
                            );
                            if (date == null) return;
                            final time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            DateTime when = DateTime(date.year, date.month,
                                date.day, time.hour, time.minute);

                            bloc.changeDeadline(when);
                          },
                        ),
                      ),
                      // Container(
                      //   // padding: const EdgeInsets.all(8.0),
                      //   child: IconButton(
                      //     icon: Icon(
                      //       Icons.label_important,
                      //       color: Theme.of(context).primaryColor,
                      //     ),
                      //     onPressed: (){}
                      //   ),
                      // ),
                      
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
      ),
    );
  }
}
