import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/often_month_enum.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_bloc.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';
import 'package:pocket_gtd/app/shared/enums/days_of_week_enum.dart';
import 'package:pocket_gtd/app/shared/enums/routine_often_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterRoutinesPage extends StatefulWidget {
  final String title;
  const RegisterRoutinesPage({Key key, this.title = "RegisterRoutines"})
      : super(key: key);

  @override
  _RegisterRoutinesPageState createState() => _RegisterRoutinesPageState();
}

class _RegisterRoutinesPageState extends State<RegisterRoutinesPage> {
  final bloc = RegisterRoutinesModule.to.bloc<RegisterRoutinesBloc>();

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
                  focusNode: bloc.focusTitle,
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
                    hintText: I18n.of(context).title,
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
                            autofocus: true,
                            textCapitalization: TextCapitalization.sentences,
                            focusNode: bloc.focusDetails,
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: <Widget>[
                    Text("Every"),
                    Container(
                      width: 32,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: bloc.oftenController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.all(6),
                            hintMaxLines: 2),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        maxLengthEnforced: true,
                        onChanged: (value) =>
                            bloc.changeOften(int.parse(value)),
                        buildCounter: (BuildContext context,
                                {@required int currentLength,
                                @required int maxLength,
                                @required bool isFocused}) =>
                            Container(),
                        cursorWidth: 2,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: StreamBuilder<int>(
                        stream: bloc.often,
                        initialData: 1,
                        builder: (context, snapshotOften) {
                          return StreamBuilder<RoutineOftenEnum>(
                              stream: bloc.routineOften,
                              initialData: RoutineOftenEnum.DAY,
                              builder: (context, snapshot) {
                                return DropdownButton<RoutineOftenEnum>(
                                  items: bloc
                                      .getRoutinerOftenOptions(
                                          context, snapshotOften.data > 1)
                                      .entries
                                      .map<DropdownMenuItem<RoutineOftenEnum>>(
                                          (item) {
                                    return DropdownMenuItem<RoutineOftenEnum>(
                                        child: Text(item.key),
                                        value: item.value);
                                  }).toList(),
                                  value: RoutineOftenEnum.DAY,
                                  onChanged: bloc.changeRoutineOften,
                                );
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<List<DaysOfWeekEnum>>(
                  stream: bloc.daysOfWeekSelected,
                  builder: (context, snapshot) {
                    return Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: Row(
                          children:
                              bloc.getRoutineDays(context).entries.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                            label: Text(item.key),
                            labelStyle: TextStyle(
                              color: bloc.listDaysOfWeek.contains(item.value)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            shadowColor: Colors.white,
                            disabledColor: Colors.black,
                            selectedShadowColor: Colors.white,
                            selectedColor: Theme.of(context).primaryColor,
                            elevation: 2,
                            selected: bloc.listDaysOfWeek.contains(item.value),
                            onSelected: (value) =>
                                bloc.changeDaysOfWeek(item.value, value),
                            // onPressed: (){},
                            // selected: true,
                          ),
                        );
                      }).toList()),
                    );
                  }),
              StreamBuilder<OftenMonthEnum>(
                stream: bloc.oftenMonth,
                initialData: OftenMonthEnum.SPECIFIC_DAY,
                builder: (context, snapshot) {
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RadioListTile<OftenMonthEnum>(
                            value: OftenMonthEnum.SPECIFIC_DAY,
                            groupValue: snapshot.data,
                            title: DropdownButton(
                              items: null,
                              onChanged: (v) {},
                            ),
                            onChanged: bloc.changeOftenMonth),
                        RadioListTile<OftenMonthEnum>(
                            value: OftenMonthEnum.WEEK_DAY,
                            title: Text("D"),
                            groupValue: snapshot.data,
                            onChanged: bloc.changeOftenMonth),
                      ],
                    ),
                  );
                },
              ),
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
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            MdiIcons.alarm,
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

                            DateTime notification = DateTime(date.year,
                                date.month, date.day, time.hour, time.minute);

                            bloc.changeNotification(notification);
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
      ),
    );
  }
}
