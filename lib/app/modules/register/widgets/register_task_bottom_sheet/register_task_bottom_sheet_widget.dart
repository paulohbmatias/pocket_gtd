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
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black45),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: bloc.titleController,
                    textCapitalization: TextCapitalization.sentences,
                    focusNode: bloc.focusTitle,
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      labelText: I18n.of(context).title,
                    ),
                    onChanged: bloc.changeTitle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: bloc.contentController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      labelText: I18n.of(context).content,
                    ),
                    maxLines: 4,
                    minLines: 2,
                    onChanged: bloc.changeDescription,
                  ),
                ),
                StreamBuilder<String>(
                    stream: bloc.deadline,
                    initialData: "",
                    builder: (context, snapshot) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        width: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text(I18n.of(context).add),
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
          ),
        ],
      ),
    );
  }
}
