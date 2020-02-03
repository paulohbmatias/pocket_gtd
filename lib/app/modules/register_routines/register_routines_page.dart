import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/initial_day_of_month_enum.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/often_month_enum.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_bloc.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';
import 'package:pocket_gtd/app/modules/register_routines/widgets/days/days_widget.dart';
import 'package:pocket_gtd/app/modules/register_routines/widgets/months/months_widget.dart';
import 'package:pocket_gtd/app/modules/register_routines/widgets/weeks/weeks_widget.dart';
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
                    Text(I18n.of(context).every),
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
                                  value: snapshot.data,
                                  onChanged: bloc.changeRoutineOften,
                                );
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<RoutineOftenEnum>(
                stream: bloc.routineOften,
                initialData: RoutineOftenEnum.DAY,
                builder: (context, snapshot) {
                  switch (snapshot.data) {
                    case RoutineOftenEnum.DAY:
                      return DaysWidget();
                    case RoutineOftenEnum.WEEK:
                      return WeeksWidget();
                    case RoutineOftenEnum.MONTH:
                      return MonthsWidget();
                    case RoutineOftenEnum.YEAR:
                      return Container();
                  }
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
